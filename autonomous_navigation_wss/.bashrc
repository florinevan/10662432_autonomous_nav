__expand_tilde_by_ref () 
{ 
    if [[ ${!1} == \~* ]]; then
        if [[ ${!1} == */* ]]; then
            eval $1="${!1/%\/*}"/'${!1#*/}';
        else
            eval $1="${!1}";
        fi;
    fi
}
__get_cword_at_cursor_by_ref () 
{ 
    local cword words=();
    __reassemble_comp_words_by_ref "$1" words cword;
    local i cur index=$COMP_POINT lead=${COMP_LINE:0:$COMP_POINT};
    if [[ $index -gt 0 && ( -n $lead && -n ${lead//[[:space:]]} ) ]]; then
        cur=$COMP_LINE;
        for ((i = 0; i <= cword; ++i ))
        do
            while [[ ${#cur} -ge ${#words[i]} && "${cur:0:${#words[i]}}" != "${words[i]}" ]]; do
                cur="${cur:1}";
                ((index--));
            done;
            if [[ $i -lt $cword ]]; then
                local old_size=${#cur};
                cur="${cur#"${words[i]}"}";
                local new_size=${#cur};
                index=$(( index - old_size + new_size ));
            fi;
        done;
        [[ -n $cur && ! -n ${cur//[[:space:]]} ]] && cur=;
        [[ $index -lt 0 ]] && index=0;
    fi;
    local "$2" "$3" "$4" && _upvars -a${#words[@]} $2 "${words[@]}" -v $3 "$cword" -v $4 "${cur:0:$index}"
}
__git_eread () 
{ 
    local f="$1";
    shift;
    test -r "$f" && read "$@" < "$f"
}
__git_ps1 () 
{ 
    local exit=$?;
    local pcmode=no;
    local detached=no;
    local ps1pc_start='\u@\h:\w ';
    local ps1pc_end='\$ ';
    local printf_format=' (%s)';
    case "$#" in 
        2 | 3)
            pcmode=yes;
            ps1pc_start="$1";
            ps1pc_end="$2";
            printf_format="${3:-$printf_format}";
            PS1="$ps1pc_start$ps1pc_end"
        ;;
        0 | 1)
            printf_format="${1:-$printf_format}"
        ;;
        *)
            return $exit
        ;;
    esac;
    local ps1_expanded=yes;
    [ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no;
    [ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=no;
    local repo_info rev_parse_exit_code;
    repo_info="$(git rev-parse --git-dir --is-inside-git-dir 		--is-bare-repository --is-inside-work-tree 		--short HEAD 2>/dev/null)";
    rev_parse_exit_code="$?";
    if [ -z "$repo_info" ]; then
        return $exit;
    fi;
    local short_sha;
    if [ "$rev_parse_exit_code" = "0" ]; then
        short_sha="${repo_info##*
}";
        repo_info="${repo_info%
*}";
    fi;
    local inside_worktree="${repo_info##*
}";
    repo_info="${repo_info%
*}";
    local bare_repo="${repo_info##*
}";
    repo_info="${repo_info%
*}";
    local inside_gitdir="${repo_info##*
}";
    local g="${repo_info%
*}";
    if [ "true" = "$inside_worktree" ] && [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] && [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] && git check-ignore -q .; then
        return $exit;
    fi;
    local r="";
    local b="";
    local step="";
    local total="";
    if [ -d "$g/rebase-merge" ]; then
        __git_eread "$g/rebase-merge/head-name" b;
        __git_eread "$g/rebase-merge/msgnum" step;
        __git_eread "$g/rebase-merge/end" total;
        if [ -f "$g/rebase-merge/interactive" ]; then
            r="|REBASE-i";
        else
            r="|REBASE-m";
        fi;
    else
        if [ -d "$g/rebase-apply" ]; then
            __git_eread "$g/rebase-apply/next" step;
            __git_eread "$g/rebase-apply/last" total;
            if [ -f "$g/rebase-apply/rebasing" ]; then
                __git_eread "$g/rebase-apply/head-name" b;
                r="|REBASE";
            else
                if [ -f "$g/rebase-apply/applying" ]; then
                    r="|AM";
                else
                    r="|AM/REBASE";
                fi;
            fi;
        else
            if [ -f "$g/MERGE_HEAD" ]; then
                r="|MERGING";
            else
                if [ -f "$g/CHERRY_PICK_HEAD" ]; then
                    r="|CHERRY-PICKING";
                else
                    if [ -f "$g/REVERT_HEAD" ]; then
                        r="|REVERTING";
                    else
                        if [ -f "$g/BISECT_LOG" ]; then
                            r="|BISECTING";
                        fi;
                    fi;
                fi;
            fi;
        fi;
        if [ -n "$b" ]; then
            :;
        else
            if [ -h "$g/HEAD" ]; then
                b="$(git symbolic-ref HEAD 2>/dev/null)";
            else
                local head="";
                if ! __git_eread "$g/HEAD" head; then
                    return $exit;
                fi;
                b="${head#ref: }";
                if [ "$head" = "$b" ]; then
                    detached=yes;
                    b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" || b="$short_sha...";
                    b="($b)";
                fi;
            fi;
        fi;
    fi;
    if [ -n "$step" ] && [ -n "$total" ]; then
        r="$r $step/$total";
    fi;
    local w="";
    local i="";
    local s="";
    local u="";
    local c="";
    local p="";
    if [ "true" = "$inside_gitdir" ]; then
        if [ "true" = "$bare_repo" ]; then
            c="BARE:";
        else
            b="GIT_DIR!";
        fi;
    else
        if [ "true" = "$inside_worktree" ]; then
            if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] && [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
                git diff --no-ext-diff --quiet || w="*";
                git diff --no-ext-diff --cached --quiet || i="+";
                if [ -z "$short_sha" ] && [ -z "$i" ]; then
                    i="#";
                fi;
            fi;
            if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] && git rev-parse --verify --quiet refs/stash > /dev/null; then
                s="$";
            fi;
            if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] && [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] && git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' > /dev/null 2> /dev/null; then
                u="%${ZSH_VERSION+%}";
            fi;
            if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
                __git_ps1_show_upstream;
            fi;
        fi;
    fi;
    local z="${GIT_PS1_STATESEPARATOR-" "}";
    if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
        __git_ps1_colorize_gitstring;
    fi;
    b=${b##refs/heads/};
    if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
        __git_ps1_branch_name=$b;
        b="\${__git_ps1_branch_name}";
    fi;
    local f="$w$i$s$u";
    local gitstring="$c$b${f:+$z$f}$r$p";
    if [ $pcmode = yes ]; then
        if [ "${__git_printf_supports_v-}" != yes ]; then
            gitstring=$(printf -- "$printf_format" "$gitstring");
        else
            printf -v gitstring -- "$printf_format" "$gitstring";
        fi;
        PS1="$ps1pc_start$gitstring$ps1pc_end";
    else
        printf -- "$printf_format" "$gitstring";
    fi;
    return $exit
}
__git_ps1_colorize_gitstring () 
{ 
    if [[ -n ${ZSH_VERSION-} ]]; then
        local c_red='%F{red}';
        local c_green='%F{green}';
        local c_lblue='%F{blue}';
        local c_clear='%f';
    else
        local c_red='\[\e[31m\]';
        local c_green='\[\e[32m\]';
        local c_lblue='\[\e[1;34m\]';
        local c_clear='\[\e[0m\]';
    fi;
    local bad_color=$c_red;
    local ok_color=$c_green;
    local flags_color="$c_lblue";
    local branch_color="";
    if [ $detached = no ]; then
        branch_color="$ok_color";
    else
        branch_color="$bad_color";
    fi;
    c="$branch_color$c";
    z="$c_clear$z";
    if [ "$w" = "*" ]; then
        w="$bad_color$w";
    fi;
    if [ -n "$i" ]; then
        i="$ok_color$i";
    fi;
    if [ -n "$s" ]; then
        s="$flags_color$s";
    fi;
    if [ -n "$u" ]; then
        u="$bad_color$u";
    fi;
    r="$c_clear$r"
}
__git_ps1_show_upstream () 
{ 
    local key value;
    local svn_remote svn_url_pattern count n;
    local upstream=git legacy="" verbose="" name="";
    svn_remote=();
    local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')";
    while read -r key value; do
        case "$key" in 
            bash.showupstream)
                GIT_PS1_SHOWUPSTREAM="$value";
                if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
                    p="";
                    return;
                fi
            ;;
            svn-remote.*.url)
                svn_remote[$((${#svn_remote[@]} + 1))]="$value";
                svn_url_pattern="$svn_url_pattern\\|$value";
                upstream=svn+git
            ;;
        esac;
    done <<< "$output";
    for option in ${GIT_PS1_SHOWUPSTREAM};
    do
        case "$option" in 
            git | svn)
                upstream="$option"
            ;;
            verbose)
                verbose=1
            ;;
            legacy)
                legacy=1
            ;;
            name)
                name=1
            ;;
        esac;
    done;
    case "$upstream" in 
        git)
            upstream="@{upstream}"
        ;;
        svn*)
            local -a svn_upstream;
            svn_upstream=($(git log --first-parent -1 					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null));
            if [[ 0 -ne ${#svn_upstream[@]} ]]; then
                svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]};
                svn_upstream=${svn_upstream%@*};
                local n_stop="${#svn_remote[@]}";
                for ((n=1; n <= n_stop; n++))
                do
                    svn_upstream=${svn_upstream#${svn_remote[$n]}};
                done;
                if [[ -z "$svn_upstream" ]]; then
                    upstream=${GIT_SVN_ID:-git-svn};
                else
                    upstream=${svn_upstream#/};
                fi;
            else
                if [[ "svn+git" = "$upstream" ]]; then
                    upstream="@{upstream}";
                fi;
            fi
        ;;
    esac;
    if [[ -z "$legacy" ]]; then
        count="$(git rev-list --count --left-right 				"$upstream"...HEAD 2>/dev/null)";
    else
        local commits;
        if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"; then
            local commit behind=0 ahead=0;
            for commit in $commits;
            do
                case "$commit" in 
                    "<"*)
                        ((behind++))
                    ;;
                    *)
                        ((ahead++))
                    ;;
                esac;
            done;
            count="$behind	$ahead";
        else
            count="";
        fi;
    fi;
    if [[ -z "$verbose" ]]; then
        case "$count" in 
            "")
                p=""
            ;;
            "0	0")
                p="="
            ;;
            "0	"*)
                p=">"
            ;;
            *"	0")
                p="<"
            ;;
            *)
                p="<>"
            ;;
        esac;
    else
        case "$count" in 
            "")
                p=""
            ;;
            "0	0")
                p=" u="
            ;;
            "0	"*)
                p=" u+${count#0	}"
            ;;
            *"	0")
                p=" u-${count%	0}"
            ;;
            *)
                p=" u+${count#*	}-${count%	*}"
            ;;
        esac;
        if [[ -n "$count" && -n "$name" ]]; then
            __git_ps1_upstream_name=$(git rev-parse 				--abbrev-ref "$upstream" 2>/dev/null);
            if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
                p="$p \${__git_ps1_upstream_name}";
            else
                p="$p ${__git_ps1_upstream_name}";
                unset __git_ps1_upstream_name;
            fi;
        fi;
    fi
}
__grub_dir () 
{ 
    local i c=1 boot_dir;
    for ((c=1; c <= ${#COMP_WORDS[@]}; c++ ))
    do
        i="${COMP_WORDS[c]}";
        case "$i" in 
            --boot-directory)
                c=$((++c));
                i="${COMP_WORDS[c]}";
                boot_dir="${i##*=}";
                break
            ;;
        esac;
    done;
    boot_dir=${boot_dir-/boot};
    echo "${boot_dir%/}/grub"
}
__grub_get_last_option () 
{ 
    local i;
    for ((i=$COMP_CWORD-1; i > 0; i-- ))
    do
        if [[ "${COMP_WORDS[i]}" == -* ]]; then
            echo "${COMP_WORDS[i]}";
            break;
        fi;
    done
}
__grub_get_options_from_help () 
{ 
    local prog;
    if [ $# -ge 1 ]; then
        prog="$1";
    else
        prog="${COMP_WORDS[0]}";
    fi;
    local i IFS=" "'	''
';
    for i in $(LC_ALL=C $prog --help);
    do
        case $i in 
            --*)
                echo "${i%=*}"
            ;;
        esac;
    done
}
__grub_get_options_from_usage () 
{ 
    local prog;
    if [ $# -ge 1 ]; then
        prog="$1";
    else
        prog="${COMP_WORDS[0]}";
    fi;
    local i IFS=" "'	''
';
    for i in $(LC_ALL=C $prog --usage);
    do
        case $i in 
            \[--*\])
                i=${i#[};
                echo ${i%%?(=*)]}
            ;;
        esac;
    done
}
__grub_list_menuentries () 
{ 
    local cur="${COMP_WORDS[COMP_CWORD]}";
    local config_file=$(__grub_dir)/grub.cfg;
    if [ -f "$config_file" ]; then
        local IFS='
';
        COMPREPLY=($(compgen             -W "$( awk -F "[\"']" '/menuentry/ { print $2 }' $config_file )"             -- "$cur" ));
    fi
}
__grub_list_modules () 
{ 
    local grub_dir=$(__grub_dir);
    local IFS='
';
    COMPREPLY=($( compgen -f -X '!*/*.mod' -- "${grub_dir}/$cur" | {
         while read -r tmp; do
             [ -n $tmp ] && {
                 tmp=${tmp##*/}
                 printf '%s\n' ${tmp%.mod}
             }
         done
         }
        ))
}
__grubcomp () 
{ 
    local cur="${COMP_WORDS[COMP_CWORD]}";
    if [ $# -gt 2 ]; then
        cur="$3";
    fi;
    case "$cur" in 
        --*=)
            COMPREPLY=()
        ;;
        *)
            local IFS=' ''	''
';
            COMPREPLY=($(compgen -P "${2-}" -W "${1-}" -S "${4-}" -- "$cur"))
        ;;
    esac
}
__ltrim_colon_completions () 
{ 
    if [[ "$1" == *:* && "$COMP_WORDBREAKS" == *:* ]]; then
        local colon_word=${1%"${1##*:}"};
        local i=${#COMPREPLY[*]};
        while [[ $((--i)) -ge 0 ]]; do
            COMPREPLY[$i]=${COMPREPLY[$i]#"$colon_word"};
        done;
    fi
}
__parse_options () 
{ 
    local option option2 i IFS=' 	
,/|';
    option=;
    for i in $1;
    do
        case $i in 
            ---*)
                break
            ;;
            --?*)
                option=$i;
                break
            ;;
            -?*)
                [[ -n $option ]] || option=$i
            ;;
            *)
                break
            ;;
        esac;
    done;
    [[ -n $option ]] || return 0;
    IFS=' 	
';
    if [[ $option =~ (\[((no|dont)-?)\]). ]]; then
        option2=${option/"${BASH_REMATCH[1]}"/};
        option2=${option2%%[<{().[]*};
        printf '%s\n' "${option2/=*/=}";
        option=${option/"${BASH_REMATCH[1]}"/"${BASH_REMATCH[2]}"};
    fi;
    option=${option%%[<{().[]*};
    printf '%s\n' "${option/=*/=}"
}
__reassemble_comp_words_by_ref () 
{ 
    local exclude i j line ref;
    if [[ -n $1 ]]; then
        exclude="${1//[^$COMP_WORDBREAKS]}";
    fi;
    eval $3=$COMP_CWORD;
    if [[ -n $exclude ]]; then
        line=$COMP_LINE;
        for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++))
        do
            while [[ $i -gt 0 && ${COMP_WORDS[$i]} == +([$exclude]) ]]; do
                [[ $line != [' 	']* ]] && (( j >= 2 )) && ((j--));
                ref="$2[$j]";
                eval $2[$j]=\${!ref}\${COMP_WORDS[i]};
                [[ $i == $COMP_CWORD ]] && eval $3=$j;
                line=${line#*"${COMP_WORDS[$i]}"};
                [[ $line == [' 	']* ]] && ((j++));
                (( $i < ${#COMP_WORDS[@]} - 1)) && ((i++)) || break 2;
            done;
            ref="$2[$j]";
            eval $2[$j]=\${!ref}\${COMP_WORDS[i]};
            line=${line#*"${COMP_WORDS[i]}"};
            [[ $i == $COMP_CWORD ]] && eval $3=$j;
        done;
        [[ $i == $COMP_CWORD ]] && eval $3=$j;
    else
        eval $2=\( \"\${COMP_WORDS[@]}\" \);
    fi
}
_allowed_groups () 
{ 
    if _complete_as_root; then
        local IFS='
';
        COMPREPLY=($( compgen -g -- "$1" ));
    else
        local IFS='
 ';
        COMPREPLY=($( compgen -W             "$( id -Gn 2>/dev/null || groups 2>/dev/null )" -- "$1" ));
    fi
}
_allowed_users () 
{ 
    if _complete_as_root; then
        local IFS='
';
        COMPREPLY=($( compgen -u -- "${1:-$cur}" ));
    else
        local IFS='
 ';
        COMPREPLY=($( compgen -W             "$( id -un 2>/dev/null || whoami 2>/dev/null )" -- "${1:-$cur}" ));
    fi
}
_apport-bug () 
{ 
    local cur dashoptions prev param;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    dashoptions='-h --help --save -v --version --tag -w --window';
    case "$prev" in 
        ubuntu-bug | apport-bug)
            case "$cur" in 
                -*)
                    COMPREPLY=($( compgen -W "$dashoptions" -- $cur ))
                ;;
                *)
                    _apport_parameterless
                ;;
            esac
        ;;
        --save)
            COMPREPLY=($( compgen -o default -G "$cur*" ))
        ;;
        -w | --window)
            dashoptions="--save --tag";
            COMPREPLY=($( compgen -W "$dashoptions" -- $cur ))
        ;;
        -h | --help | -v | --version | --tag)
            return 0
        ;;
        *)
            dashoptions="--tag";
            if ! [[ "${COMP_WORDS[*]}" =~ .*--save.* ]]; then
                dashoptions="--save $dashoptions";
            fi;
            if ! [[ "${COMP_WORDS[*]}" =~ .*--window.* || "${COMP_WORDS[*]}" =~ .*\ -w\ .* ]]; then
                dashoptions="-w --window $dashoptions";
            fi;
            case "$cur" in 
                -*)
                    COMPREPLY=($( compgen -W "$dashoptions" -- $cur ))
                ;;
                *)
                    _apport_parameterless
                ;;
            esac
        ;;
    esac
}
_apport-cli () 
{ 
    local cur dashoptions prev param;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    dashoptions='-h --help -f --file-bug -u --update-bug -s --symptom \
                 -c --crash-file --save -v --version --tag -w --window';
    case "$prev" in 
        apport-cli)
            case "$cur" in 
                -*)
                    COMPREPLY=($( compgen -W "$dashoptions" -- $cur ))
                ;;
                *)
                    _apport_parameterless
                ;;
            esac
        ;;
        -f | --file-bug)
            param="-P --pid -p --package -s --symptom";
            COMPREPLY=($( compgen -W "$param $(_apport_symptoms)" -- $cur))
        ;;
        -s | --symptom)
            COMPREPLY=($( compgen -W "$(_apport_symptoms)" -- $cur))
        ;;
        --save)
            COMPREPLY=($( compgen -o default -G "$cur*" ))
        ;;
        -c | --crash-file)
            COMPREPLY=($( compgen -G "${cur}*.apport"
                       compgen -G "${cur}*.crash" ))
        ;;
        -w | --window)
            dashoptions="--save --tag";
            COMPREPLY=($( compgen -W "$dashoptions" -- $cur ))
        ;;
        -h | --help | -v | --version | --tag)
            return 0
        ;;
        *)
            dashoptions='--tag';
            if ! [[ "${COMP_WORDS[*]}" =~ .*--save.* ]]; then
                dashoptions="--save $dashoptions";
            fi;
            if ! [[ "${COMP_WORDS[*]}" =~ .*--window.* || "${COMP_WORDS[*]}" =~ .*\ -w\ .* ]]; then
                dashoptions="-w --window $dashoptions";
            fi;
            if ! [[ "${COMP_WORDS[*]}" =~ .*--symptom.* || "${COMP_WORDS[*]}" =~ .*\ -s\ .* ]]; then
                dashoptions="-s --symptom $dashoptions";
            fi;
            if ! [[ "${COMP_WORDS[*]}" =~ .*--update.* || "${COMP_WORDS[*]}" =~ .*\ -u\ .* ]]; then
                dashoptions="-u --update $dashoptions";
            fi;
            if ! [[ "${COMP_WORDS[*]}" =~ .*--file-bug.* || "${COMP_WORDS[*]}" =~ .*\ -f\ .* ]]; then
                dashoptions="-f --file-bug $dashoptions";
            fi;
            if ! [[ "${COMP_WORDS[*]}" =~ .*--crash-file.* || "${COMP_WORDS[*]}" =~ .*\ -c\ .* ]]; then
                dashoptions="-c --crash-file $dashoptions";
            fi;
            case "$cur" in 
                -*)
                    COMPREPLY=($( compgen -W "$dashoptions" -- $cur ))
                ;;
                *)
                    _apport_parameterless
                ;;
            esac
        ;;
    esac
}
_apport-collect () 
{ 
    local cur prev;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case "$prev" in 
        apport-collect)
            COMPREPLY=($( compgen -W "-p --package --tag" -- $cur))
        ;;
        -p | --package)
            COMPREPLY=($( apt-cache pkgnames $cur 2> /dev/null ))
        ;;
        --tag)
            return 0
        ;;
        *)
            if [[ "${COMP_WORDS[*]}" =~ .*\ -p.* || "${COMP_WORDS[*]}" =~ .*--package.* ]]; then
                COMPREPLY=($( compgen -W "--tag" -- $cur));
            else
                COMPREPLY=($( compgen -W "-p --package --tag" -- $cur));
            fi
        ;;
    esac
}
_apport-unpack () 
{ 
    local cur prev;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case "$prev" in 
        apport-unpack)
            COMPREPLY=($( compgen -G "${cur}*.apport"
                       compgen -G "${cur}*.crash" ))
        ;;
    esac
}
_apport_parameterless () 
{ 
    local param;
    param="$dashoptions            $( apt-cache pkgnames $cur 2> /dev/null )            $( command ps axo pid | sed 1d )            $( _apport_symptoms )            $( compgen -G "${cur}*" )";
    COMPREPLY=($( compgen -W "$param" -- $cur))
}
_apport_symptoms () 
{ 
    local syms;
    if [ -r /usr/share/apport/symptoms ]; then
        for FILE in $(ls /usr/share/apport/symptoms);
        do
            if [[ ! "$FILE" =~ ^_.* && -n $(egrep "^def run\s*\(.*\):" /usr/share/apport/symptoms/$FILE) ]]; then
                syms="$syms ${FILE%.py}";
            fi;
        done;
    fi;
    echo $syms
}
_available_interfaces () 
{ 
    local cmd PATH=$PATH:/sbin;
    if [[ ${1:-} == -w ]]; then
        cmd="iwconfig";
    else
        if [[ ${1:-} == -a ]]; then
            cmd="{ ifconfig || ip link show up; }";
        else
            cmd="{ ifconfig -a || ip link show; }";
        fi;
    fi;
    COMPREPLY=($( eval $cmd 2>/dev/null | awk         '/^[^ \t]/ { if ($1 ~ /^[0-9]+:/) { print $2 } else { print $1 } }' ));
    COMPREPLY=($( compgen -W '${COMPREPLY[@]/%[[:punct:]]/}' -- "$cur" ))
}
_catkin () 
{ 
    local cur prev words cword catkin_verbs catkin_opts;
    _init_completion || return;
    local catkin_verbs="build clean config create init list profile";
    local OPTS_FILTER='s/.*\(--[-A-Za-z0-9]\{1,\}=\{0,1\}\).*/\1/p';
    local catkin_opts=$(catkin --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
    local catkin_profile_args="add list remove rename set";
    local verb=$(_catkin_verb);
    case ${verb} in 
        "")
            if [[ ${cur} == -* ]]; then
                COMPREPLY=($(compgen -W "${catkin_opts}" -- ${cur}));
            else
                COMPREPLY=($(compgen -W "${catkin_verbs}" -- ${cur}));
            fi
        ;;
        build)
            if [[ ${cur} == -* ]]; then
                local catkin_build_opts=$(catkin build --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
                COMPREPLY=($(compgen -W "${catkin_build_opts}" -- ${cur}));
            else
                COMPREPLY=($(compgen -W "$(_catkin_pkgs)" -- ${cur}));
            fi
        ;;
        config)
            local catkin_config_opts=$(catkin config --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
            COMPREPLY=($(compgen -W "${catkin_config_opts}" -- ${cur}));
            if [[ ${cur} != -* && $(_catkin_last_option) == --*list ]]; then
                COMPREPLY+=($(compgen -W "$(_catkin_pkgs)" -- ${cur}));
            fi;
            if [[ ${prev} == --extend || ${prev} == --*-space ]]; then
                compopt -o nospace 2> /dev/null;
                COMPREPLY+=($(compgen -d -S "/" -- ${cur}));
            fi
        ;;
        clean)
            local catkin_clean_opts=$(catkin clean --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
            COMPREPLY=($(compgen -W "${catkin_clean_opts}" -- ${cur}))
        ;;
        create)
            if [[ "${words[@]}" == *" pkg"* ]]; then
                local catkin_create_pkg_opts=$(catkin create pkg --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
                COMPREPLY=($(compgen -W "${catkin_create_pkg_opts}" -- ${cur}));
            else
                COMPREPLY=($(compgen -W "pkg" -- ${cur}));
            fi
        ;;
        profile)
            case ${prev} in 
                profile)
                    COMPREPLY=($(compgen -W "${catkin_profile_args}" -- ${cur}))
                ;;
                set | rename | remove)
                    COMPREPLY=($(compgen -W "$(catkin --no-color profile list --unformatted)" -- ${cur}))
                ;;
                *)
                    COMPREPLY=()
                ;;
            esac
        ;;
        init)
            local catkin_init_opts=$(catkin init --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
            COMPREPLY=($(compgen -W "${catkin_init_opts}" -- ${cur}))
        ;;
        list)
            local catkin_list_opts=$(catkin list --help 2>&1 | sed -ne $OPTS_FILTER | sort -u);
            COMPREPLY=($(compgen -W "${catkin_list_opts}" -- ${cur}))
        ;;
    esac;
    return 0
}
_catkin_last_option () 
{ 
    for ((i=${cword} ; i > 0 ; i-- ))
    do
        if [[ ${words[i]} == -* ]]; then
            echo ${words[i]};
            return;
        fi;
    done
}
_catkin_make () 
{ 
    local cur prev;
    cur=${COMP_WORDS[COMP_CWORD]};
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case $prev in 
        -C | --directory | --source | --build)
            _filedir -d;
            return 0
        ;;
    esac;
    if [[ "$cur" == -DCMAKE_BUILD_TYPE=* ]]; then
        COMPREPLY=($( compgen -P "-DCMAKE_BUILD_TYPE=" -W "None Debug Release RelWithDebInfo MinSizeRel" -- "${cur:19}" ));
    else
        if [[ "$cur" == -DCATKIN_ENABLE_TESTING=* ]]; then
            COMPREPLY=($( compgen -P "-DCATKIN_ENABLE_TESTING=" -W "0 1" -- "${cur:24}" ));
        else
            if [[ "$cur" == -DCATKIN_DEVEL_PREFIX=* || "$cur" == -DCMAKE_INSTALL_PREFIX=* ]]; then
                COMPREPLY=();
            else
                if [[ "$cur" == -* ]]; then
                    local opts="$( _parse_help "$1" )";
                    [[ -n $opts ]] || opts="$( _parse_usage "$1" )";
                    if [[ "$cur" == -* ]]; then
                        opts="$opts -DCATKIN_DEVEL_PREFIX= -DCATKIN_ENABLE_TESTING= -DCMAKE_INSTALL_PREFIX= -DCMAKE_BUILD_TYPE=";
                    fi;
                    COMPREPLY=($( compgen -W "$opts" -- "$cur" ));
                    [[ $COMPREPLY == *= ]] && compopt -o nospace;
                else
                    local workspace_dir=".";
                    for ((i=0; i < ${#COMP_WORDS[@]}; i++ ))
                    do
                        if [[ ${COMP_WORDS[i]} == -C || ${COMP_WORDS[i]} == --directory ]]; then
                            eval workspace_dir=${COMP_WORDS[i+1]};
                        fi;
                    done;
                    local build_dir="build";
                    for ((i=0; i < ${#COMP_WORDS[@]}; i++ ))
                    do
                        if [[ ${COMP_WORDS[i]} == --build ]]; then
                            eval build_dir=${COMP_WORDS[i+1]};
                        fi;
                    done;
                    local makefile_dir;
                    if [[ "$build_dir" = /* ]]; then
                        makefile_dir="$build_dir";
                    else
                        makefile_dir="$workspace_dir/$build_dir";
                    fi;
                    COMPREPLY=();
                    if [ -f "$makefile_dir/Makefile" ]; then
                        cur=${COMP_WORDS[COMP_CWORD]};
                        COMPREPLY=($( compgen -W "`make -C $makefile_dir -qp 2>/dev/null | awk -F':' '/^[a-zA-Z0-9][a-zA-Z0-9_\.]*:/ { print $1 }'`" -- $cur ));
                    else
                        if [ -f "$makefile_dir/build.ninja" ]; then
                            cur=${COMP_WORDS[COMP_CWORD]};
                            COMPREPLY=($( compgen -W "`ninja -C $makefile_dir -t targets 2>/dev/null | awk -F':' '/^[a-zA-Z0-9][a-zA-Z0-9_\.]*:/ { print $1 }'`" -- $cur ));
                        fi;
                    fi;
                fi;
            fi;
        fi;
    fi
}
_catkin_make_isolated () 
{ 
    local cur prev;
    cur=${COMP_WORDS[COMP_CWORD]};
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case $prev in 
        -C | --directory | --source | --build | --devel | --install)
            _filedir -d;
            return 0
        ;;
    esac;
    if [[ "$cur" == -DCMAKE_BUILD_TYPE=* ]]; then
        COMPREPLY=($( compgen -P "-DCMAKE_BUILD_TYPE=" -W "None Debug Release RelWithDebInfo MinSizeRel" -- "${cur:19}" ));
    else
        if [[ "$cur" == -DCATKIN_ENABLE_TESTING=* ]]; then
            COMPREPLY=($( compgen -P "-DCATKIN_ENABLE_TESTING=" -W "0 1" -- "${cur:24}" ));
        else
            if [[ "$cur" == -* ]]; then
                local opts="$( _parse_help "$1" )";
                [[ -n $opts ]] || opts="$( _parse_usage "$1" )";
                if [[ "$cur" == -* ]]; then
                    opts="$opts -DCATKIN_ENABLE_TESTING= -DCMAKE_BUILD_TYPE=";
                fi;
                COMPREPLY=($( compgen -W "$opts" -- "$cur" ));
                [[ $COMPREPLY == *= ]] && compopt -o nospace;
            else
                local workspace_dir=".";
                for ((i=0; i < ${#COMP_WORDS[@]}; i++ ))
                do
                    if [[ ${COMP_WORDS[i]} == -C || ${COMP_WORDS[i]} == --directory ]]; then
                        eval workspace_dir=${COMP_WORDS[i+1]};
                    fi;
                done;
                local build_dir="build_isolated";
                for ((i=0; i < ${#COMP_WORDS[@]}; i++ ))
                do
                    if [[ ${COMP_WORDS[i]} == --build ]]; then
                        eval build_dir=${COMP_WORDS[i+1]};
                    fi;
                done;
                local makefile_dir;
                if [[ "$build_dir" = /* ]]; then
                    makefile_dir="$build_dir";
                else
                    makefile_dir="$workspace_dir/$build_dir";
                fi;
                COMPREPLY=();
                if [ -f "$makefile_dir/Makefile" ]; then
                    cur=${COMP_WORDS[COMP_CWORD]};
                    COMPREPLY=($( compgen -W "`make -C $makefile_dir -qp 2>/dev/null | awk -F':' '/^[a-zA-Z0-9][a-zA-Z0-9_\.]*:/ { print $1 }'`" -- $cur ));
                else
                    if [ -f "$makefile_dir/build.ninja" ]; then
                        cur=${COMP_WORDS[COMP_CWORD]};
                        COMPREPLY=($( compgen -W "`ninja -C $makefile_dir -t targets 2>/dev/null | awk -F':' '/^[a-zA-Z0-9][a-zA-Z0-9_\.]*:/ { print $1 }'`" -- $cur ));
                    fi;
                fi;
            fi;
        fi;
    fi
}
_catkin_pkgs () 
{ 
    catkin --no-color list --unformatted --quiet 2> /dev/null
}
_catkin_verb () 
{ 
    for ((i=1 ; i < ${cword} ; i++ ))
    do
        if [[ ${words[i]} == -* ]]; then
            continue;
        fi;
        if [[ ${catkin_verbs} == *${words[i]}* ]]; then
            echo ${words[i]};
            return;
        fi;
    done
}
_cd () 
{ 
    local cur prev words cword;
    _init_completion || return;
    local IFS='
' i j k;
    compopt -o filenames;
    if [[ -z "${CDPATH:-}" || "$cur" == ?(.)?(.)/* ]]; then
        _filedir -d;
        return 0;
    fi;
    local -r mark_dirs=$(_rl_enabled mark-directories && echo y);
    local -r mark_symdirs=$(_rl_enabled mark-symlinked-directories && echo y);
    for i in ${CDPATH//:/'
'};
    do
        k="${#COMPREPLY[@]}";
        for j in $( compgen -d $i/$cur );
        do
            if [[ ( -n $mark_symdirs && -h $j || -n $mark_dirs && ! -h $j ) && ! -d ${j#$i/} ]]; then
                j+="/";
            fi;
            COMPREPLY[k++]=${j#$i/};
        done;
    done;
    _filedir -d;
    if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
        i=${COMPREPLY[0]};
        if [[ "$i" == "$cur" && $i != "*/" ]]; then
            COMPREPLY[0]="${i}/";
        fi;
    fi;
    return 0
}
_cd_devices () 
{ 
    COMPREPLY+=($( compgen -f -d -X "!*/?([amrs])cd*" -- "${cur:-/dev/}" ))
}
_command () 
{ 
    local offset i;
    offset=1;
    for ((i=1; i <= COMP_CWORD; i++ ))
    do
        if [[ "${COMP_WORDS[i]}" != -* ]]; then
            offset=$i;
            break;
        fi;
    done;
    _command_offset $offset
}
_command_offset () 
{ 
    local word_offset=$1 i j;
    for ((i=0; i < $word_offset; i++ ))
    do
        for ((j=0; j <= ${#COMP_LINE}; j++ ))
        do
            [[ "$COMP_LINE" == "${COMP_WORDS[i]}"* ]] && break;
            COMP_LINE=${COMP_LINE:1};
            ((COMP_POINT--));
        done;
        COMP_LINE=${COMP_LINE#"${COMP_WORDS[i]}"};
        ((COMP_POINT-=${#COMP_WORDS[i]}));
    done;
    for ((i=0; i <= COMP_CWORD - $word_offset; i++ ))
    do
        COMP_WORDS[i]=${COMP_WORDS[i+$word_offset]};
    done;
    for ((i; i <= COMP_CWORD; i++ ))
    do
        unset COMP_WORDS[i];
    done;
    ((COMP_CWORD -= $word_offset));
    COMPREPLY=();
    local cur;
    _get_comp_words_by_ref cur;
    if [[ $COMP_CWORD -eq 0 ]]; then
        local IFS='
';
        compopt -o filenames;
        COMPREPLY=($( compgen -d -c -- "$cur" ));
    else
        local cmd=${COMP_WORDS[0]} compcmd=${COMP_WORDS[0]};
        local cspec=$( complete -p $cmd 2>/dev/null );
        if [[ ! -n $cspec && $cmd == */* ]]; then
            cspec=$( complete -p ${cmd##*/} 2>/dev/null );
            [[ -n $cspec ]] && compcmd=${cmd##*/};
        fi;
        if [[ ! -n $cspec ]]; then
            compcmd=${cmd##*/};
            _completion_loader $compcmd;
            cspec=$( complete -p $compcmd 2>/dev/null );
        fi;
        if [[ -n $cspec ]]; then
            if [[ ${cspec#* -F } != $cspec ]]; then
                local func=${cspec#*-F };
                func=${func%% *};
                if [[ ${#COMP_WORDS[@]} -ge 2 ]]; then
                    $func $cmd "${COMP_WORDS[${#COMP_WORDS[@]}-1]}" "${COMP_WORDS[${#COMP_WORDS[@]}-2]}";
                else
                    $func $cmd "${COMP_WORDS[${#COMP_WORDS[@]}-1]}";
                fi;
                local opt;
                while [[ $cspec == *" -o "* ]]; do
                    cspec=${cspec#*-o };
                    opt=${cspec%% *};
                    compopt -o $opt;
                    cspec=${cspec#$opt};
                done;
            else
                cspec=${cspec#complete};
                cspec=${cspec%%$compcmd};
                COMPREPLY=($( eval compgen "$cspec" -- '$cur' ));
            fi;
        else
            if [[ ${#COMPREPLY[@]} -eq 0 ]]; then
                _minimal;
            fi;
        fi;
    fi
}
_complete_as_root () 
{ 
    [[ $EUID -eq 0 || -n ${root_command:-} ]]
}
_completion_loader () 
{ 
    local compfile=./completions;
    [[ $BASH_SOURCE == */* ]] && compfile="${BASH_SOURCE%/*}/completions";
    compfile+="/${1##*/}";
    [[ -f "$compfile" ]] && . "$compfile" &> /dev/null && return 124;
    complete -F _minimal "$1" && return 124
}
_configured_interfaces () 
{ 
    if [[ -f /etc/debian_version ]]; then
        COMPREPLY=($( compgen -W "$( sed -ne 's|^iface \([^ ]\{1,\}\).*$|\1|p'            /etc/network/interfaces )" -- "$cur" ));
    else
        if [[ -f /etc/SuSE-release ]]; then
            COMPREPLY=($( compgen -W "$( printf '%s\n'             /etc/sysconfig/network/ifcfg-* |             sed -ne 's|.*ifcfg-\(.*\)|\1|p' )" -- "$cur" ));
        else
            if [[ -f /etc/pld-release ]]; then
                COMPREPLY=($( compgen -W "$( command ls -B             /etc/sysconfig/interfaces |             sed -ne 's|.*ifcfg-\(.*\)|\1|p' )" -- "$cur" ));
            else
                COMPREPLY=($( compgen -W "$( printf '%s\n'             /etc/sysconfig/network-scripts/ifcfg-* |             sed -ne 's|.*ifcfg-\(.*\)|\1|p' )" -- "$cur" ));
            fi;
        fi;
    fi
}
_count_args () 
{ 
    local i cword words;
    __reassemble_comp_words_by_ref "$1" words cword;
    args=1;
    for i in "${words[@]:1:cword-1}";
    do
        [[ "$i" != -* ]] && args=$(($args+1));
    done
}
_desktop_file_validate () 
{ 
    COMPRELY=();
    cur=${COMP_WORDS[COMP_CWORD]};
    _filedir '@(desktop)'
}
_dkms () 
{ 
    local cur prev command module i;
    COMPREPLY=();
    cur=${COMP_WORDS[COMP_CWORD]};
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($( compgen -W "add autoinstall remove build install uninstall 			match mkdriverdisk mktarball ldtarball mkrpm mkdeb mkdsc mkkmp 			status" -- $cur ));
    else
        prev=${COMP_WORDS[COMP_CWORD-1]};
        command=${COMP_WORDS[1]};
        case $prev in 
            -m)
                if [ "$command" = 'add' ]; then
                    _filename_parts '.*-.*' 1;
                else
                    _subdirectories /var/lib/dkms;
                fi;
                return 0
            ;;
            -v)
                for ((i=1; i < COMP_CWORD; i++ ))
                do
                    if [[ "${COMP_WORDS[i]}" == -m ]]; then
                        module=${COMP_WORDS[i+1]};
                        break;
                    fi;
                done;
                if [ -n "$module" ]; then
                    if [ "$command" = 'add' ]; then
                        _filename_parts "$module-.*" 2;
                    else
                        _subdirectories /var/lib/dkms/$module;
                    fi;
                    return 0;
                fi
            ;;
            -k)
                _kernels;
                return 0
            ;;
            -@\(c | -spec | -archive | -config\))
                _filedir;
                return 0
            ;;
            --kernelsourcedir)
                _filedir -d;
                return 0
            ;;
        esac;
        if [[ "$cur" == -* ]]; then
            case $command in 
                add)
                    options='-c --rpm_safe_upgrade'
                ;;
                remove)
                    options='--rpm_safe_upgrade'
                ;;
                build)
                    options='--config'
                ;;
                mkdriverdisk)
                    options='-d --distro -r --release --size'
                ;;
                ldtarball)
                    options='--archive --force'
                ;;
                mktarball)
                    options='--source-only --binaries-only'
                ;;
                mkrpm)
                    options='--source-only'
                ;;
                mkkmp)
                    options='--spec'
                ;;
                match)
                    options='--templatekernel'
                ;;
            esac;
            options="$options -m -v -k -a --arch -q --quiet -V 				--version --all --no-prepare-kernel 				--no-clean-kernel --kernelsourcedir 				--directive";
            COMPREPLY=($( compgen -W "$options" -- $cur ));
        fi;
    fi
}
_dvd_devices () 
{ 
    COMPREPLY+=($( compgen -f -d -X "!*/?(r)dvd*" -- "${cur:-/dev/}" ))
}
_expand () 
{ 
    if [[ "$cur" == \~*/* ]]; then
        eval cur=$cur 2> /dev/null;
    else
        if [[ "$cur" == \~* ]]; then
            cur=${cur#\~};
            COMPREPLY=($( compgen -P '~' -u "$cur" ));
            [[ ${#COMPREPLY[@]} -eq 1 ]] && eval COMPREPLY[0]=${COMPREPLY[0]};
            return ${#COMPREPLY[@]};
        fi;
    fi
}
_filedir () 
{ 
    local i IFS='
' xspec;
    _tilde "$cur" || return 0;
    local -a toks;
    local quoted x tmp;
    _quote_readline_by_ref "$cur" quoted;
    x=$( compgen -d -- "$quoted" ) && while read -r tmp; do
        toks+=("$tmp");
    done <<< "$x";
    if [[ "$1" != -d ]]; then
        xspec=${1:+"!*.@($1|${1^^})"};
        x=$( compgen -f -X "$xspec" -- $quoted ) && while read -r tmp; do
            toks+=("$tmp");
        done <<< "$x";
    fi;
    [[ -n ${COMP_FILEDIR_FALLBACK:-} && -n "$1" && "$1" != -d && ${#toks[@]} -lt 1 ]] && x=$( compgen -f -- $quoted ) && while read -r tmp; do
        toks+=("$tmp");
    done <<< "$x";
    if [[ ${#toks[@]} -ne 0 ]]; then
        compopt -o filenames 2> /dev/null;
        COMPREPLY+=("${toks[@]}");
    fi
}
_filedir_xspec () 
{ 
    local cur prev words cword;
    _init_completion || return;
    _tilde "$cur" || return 0;
    local IFS='
' xspec=${_xspecs[${1##*/}]} tmp;
    local -a toks;
    toks=($(
        compgen -d -- "$(quote_readline "$cur")" | {
        while read -r tmp; do
            printf '%s\n' $tmp
        done
        }
        ));
    eval xspec="${xspec}";
    local matchop=!;
    if [[ $xspec == !* ]]; then
        xspec=${xspec#!};
        matchop=@;
    fi;
    xspec="$matchop($xspec|${xspec^^})";
    toks+=($(
        eval compgen -f -X "!$xspec" -- "\$(quote_readline "\$cur")" | {
        while read -r tmp; do
            [[ -n $tmp ]] && printf '%s\n' $tmp
        done
        }
        ));
    if [[ ${#toks[@]} -ne 0 ]]; then
        compopt -o filenames;
        COMPREPLY=("${toks[@]}");
    fi
}
_filename_parts () 
{ 
    COMPREPLY=($( command ls -F /usr/src/ 2>/dev/null | grep -E '^'$1'/$' 		| sed -r -e 's/^([^-]+)-(.+)\/$/\'$2'/' | grep "^$cur" ))
}
_fstypes () 
{ 
    local fss;
    if [[ -e /proc/filesystems ]]; then
        fss="$( cut -d'	' -f2 /proc/filesystems )
             $( awk '! /\*/ { print $NF }' /etc/filesystems 2>/dev/null )";
    else
        fss="$( awk '/^[ \t]*[^#]/ { print $3 }' /etc/fstab 2>/dev/null )
             $( awk '/^[ \t]*[^#]/ { print $3 }' /etc/mnttab 2>/dev/null )
             $( awk '/^[ \t]*[^#]/ { print $4 }' /etc/vfstab 2>/dev/null )
             $( awk '{ print $1 }' /etc/dfs/fstypes 2>/dev/null )
             $( [[ -d /etc/fs ]] && command ls /etc/fs )";
    fi;
    [[ -n $fss ]] && COMPREPLY+=($( compgen -W "$fss" -- "$cur" ))
}
_get_comp_words_by_ref () 
{ 
    local exclude flag i OPTIND=1;
    local cur cword words=();
    local upargs=() upvars=() vcur vcword vprev vwords;
    while getopts "c:i:n:p:w:" flag "$@"; do
        case $flag in 
            c)
                vcur=$OPTARG
            ;;
            i)
                vcword=$OPTARG
            ;;
            n)
                exclude=$OPTARG
            ;;
            p)
                vprev=$OPTARG
            ;;
            w)
                vwords=$OPTARG
            ;;
        esac;
    done;
    while [[ $# -ge $OPTIND ]]; do
        case ${!OPTIND} in 
            cur)
                vcur=cur
            ;;
            prev)
                vprev=prev
            ;;
            cword)
                vcword=cword
            ;;
            words)
                vwords=words
            ;;
            *)
                echo "bash: $FUNCNAME(): \`${!OPTIND}': unknown argument" 1>&2;
                return 1
            ;;
        esac;
        let "OPTIND += 1";
    done;
    __get_cword_at_cursor_by_ref "$exclude" words cword cur;
    [[ -n $vcur ]] && { 
        upvars+=("$vcur");
        upargs+=(-v $vcur "$cur")
    };
    [[ -n $vcword ]] && { 
        upvars+=("$vcword");
        upargs+=(-v $vcword "$cword")
    };
    [[ -n $vprev && $cword -ge 1 ]] && { 
        upvars+=("$vprev");
        upargs+=(-v $vprev "${words[cword - 1]}")
    };
    [[ -n $vwords ]] && { 
        upvars+=("$vwords");
        upargs+=(-a${#words[@]} $vwords "${words[@]}")
    };
    (( ${#upvars[@]} )) && local "${upvars[@]}" && _upvars "${upargs[@]}"
}
_get_cword () 
{ 
    local LC_CTYPE=C;
    local cword words;
    __reassemble_comp_words_by_ref "$1" words cword;
    if [[ -n ${2//[^0-9]/} ]]; then
        printf "%s" "${words[cword-$2]}";
    else
        if [[ "${#words[cword]}" -eq 0 || "$COMP_POINT" == "${#COMP_LINE}" ]]; then
            printf "%s" "${words[cword]}";
        else
            local i;
            local cur="$COMP_LINE";
            local index="$COMP_POINT";
            for ((i = 0; i <= cword; ++i ))
            do
                while [[ "${#cur}" -ge ${#words[i]} && "${cur:0:${#words[i]}}" != "${words[i]}" ]]; do
                    cur="${cur:1}";
                    ((index--));
                done;
                if [[ "$i" -lt "$cword" ]]; then
                    local old_size="${#cur}";
                    cur="${cur#${words[i]}}";
                    local new_size="${#cur}";
                    index=$(( index - old_size + new_size ));
                fi;
            done;
            if [[ "${words[cword]:0:${#cur}}" != "$cur" ]]; then
                printf "%s" "${words[cword]}";
            else
                printf "%s" "${cur:0:$index}";
            fi;
        fi;
    fi
}
_get_first_arg () 
{ 
    local i;
    arg=;
    for ((i=1; i < COMP_CWORD; i++ ))
    do
        if [[ "${COMP_WORDS[i]}" != -* ]]; then
            arg=${COMP_WORDS[i]};
            break;
        fi;
    done
}
_get_pword () 
{ 
    if [[ $COMP_CWORD -ge 1 ]]; then
        _get_cword "${@:-}" 1;
    fi
}
_gids () 
{ 
    if type getent &> /dev/null; then
        COMPREPLY=($( compgen -W '$( getent group | cut -d: -f3 )'             -- "$cur" ));
    else
        if type perl &> /dev/null; then
            COMPREPLY=($( compgen -W '$( perl -e '"'"'while (($gid) = (getgrent)[2]) { print $gid . "\n" }'"'"' )' -- "$cur" ));
        else
            COMPREPLY=($( compgen -W '$( cut -d: -f3 /etc/group )' -- "$cur" ));
        fi;
    fi
}
_grub_editenv () 
{ 
    local cur prev;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case "$prev" in 
        create | list | set | unset)
            COMPREPLY=("");
            return
        ;;
    esac;
    __grubcomp "$(__grub_get_options_from_help)
                create list set unset"
}
_grub_install () 
{ 
    local cur prev last split=false;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    last=$(__grub_get_last_option);
    _split_longopt && split=true;
    case "$prev" in 
        --boot-directory)
            _filedir -d;
            return
        ;;
        --disk-module)
            __grubcomp "biosdisk ata";
            return
        ;;
    esac;
    $split && return 0;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        case "$last" in 
            --modules)
                __grub_list_modules;
                return
            ;;
        esac;
        _filedir;
    fi
}
_grub_mkconfig () 
{ 
    local cur prev;
    COMPREPLY=();
    cur=`_get_cword`;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_grub_mkfont () 
{ 
    local cur;
    COMPREPLY=();
    cur=`_get_cword`;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_grub_mkimage () 
{ 
    local cur prev split=false;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    _split_longopt && split=true;
    case "$prev" in 
        -d | --directory | -p | --prefix)
            _filedir -d;
            return
        ;;
        -O | --format)
            local prog=${COMP_WORDS[0]};
            __grubcomp "$(LC_ALL=C $prog --help |                         awk -F ":" '/available formats/ { print $2 }' |                         sed 's/, / /g')";
            return
        ;;
    esac;
    $split && return 0;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_grub_mkpasswd_pbkdf2 () 
{ 
    local cur;
    COMPREPLY=();
    cur=`_get_cword`;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_grub_mkrescue () 
{ 
    local cur prev last;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    last=$(__grub_get_last_option);
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        case "$last" in 
            --modules)
                __grub_list_modules;
                return
            ;;
        esac;
        _filedir;
    fi
}
_grub_probe () 
{ 
    local cur prev split=false;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    _split_longopt && split=true;
    case "$prev" in 
        -t | --target)
            local prog=${COMP_WORDS[0]};
            __grubcomp "$(LC_ALL=C $prog --help |                         awk -F "[()]" '/--target=/ { print $2 }' |                         sed 's/|/ /g')";
            return
        ;;
    esac;
    $split && return 0;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_grub_script_check () 
{ 
    local cur;
    COMPREPLY=();
    cur=`_get_cword`;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_grub_set_entry () 
{ 
    local cur prev split=false;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    _split_longopt && split=true;
    case "$prev" in 
        --boot-directory)
            _filedir -d;
            return
        ;;
    esac;
    $split && return 0;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        __grub_list_menuentries;
    fi
}
_grub_setup () 
{ 
    local cur prev split=false;
    COMPREPLY=();
    cur=`_get_cword`;
    prev=${COMP_WORDS[COMP_CWORD-1]};
    _split_longopt && split=true;
    case "$prev" in 
        -d | --directory)
            _filedir -d;
            return
        ;;
    esac;
    $split && return 0;
    if [[ "$cur" == -* ]]; then
        __grubcomp "$(__grub_get_options_from_help)";
    else
        _filedir;
    fi
}
_have () 
{ 
    PATH=$PATH:/usr/sbin:/sbin:/usr/local/sbin type $1 &> /dev/null
}
_init_completion () 
{ 
    local exclude= flag outx errx inx OPTIND=1;
    while getopts "n:e:o:i:s" flag "$@"; do
        case $flag in 
            n)
                exclude+=$OPTARG
            ;;
            e)
                errx=$OPTARG
            ;;
            o)
                outx=$OPTARG
            ;;
            i)
                inx=$OPTARG
            ;;
            s)
                split=false;
                exclude+==
            ;;
        esac;
    done;
    COMPREPLY=();
    local redir="@(?([0-9])<|?([0-9&])>?(>)|>&)";
    _get_comp_words_by_ref -n "$exclude<>&" cur prev words cword;
    _variables && return 1;
    if [[ $cur == $redir* || $prev == $redir ]]; then
        local xspec;
        case $cur in 
            2'>'*)
                xspec=$errx
            ;;
            *'>'*)
                xspec=$outx
            ;;
            *'<'*)
                xspec=$inx
            ;;
            *)
                case $prev in 
                    2'>'*)
                        xspec=$errx
                    ;;
                    *'>'*)
                        xspec=$outx
                    ;;
                    *'<'*)
                        xspec=$inx
                    ;;
                esac
            ;;
        esac;
        cur="${cur##$redir}";
        _filedir $xspec;
        return 1;
    fi;
    local i skip;
    for ((i=1; i < ${#words[@]}; 1))
    do
        if [[ ${words[i]} == $redir* ]]; then
            [[ ${words[i]} == $redir ]] && skip=2 || skip=1;
            words=("${words[@]:0:i}" "${words[@]:i+skip}");
            [[ $i -le $cword ]] && cword=$(( cword - skip ));
        else
            i=$(( ++i ));
        fi;
    done;
    [[ $cword -le 0 ]] && return 1;
    prev=${words[cword-1]};
    [[ -n ${split-} ]] && _split_longopt && split=true;
    return 0
}
_installed_modules () 
{ 
    COMPREPLY=($( compgen -W "$( PATH="$PATH:/sbin" lsmod |         awk '{if (NR != 1) print $1}' )" -- "$1" ))
}
_ip_addresses () 
{ 
    local PATH=$PATH:/sbin;
    COMPREPLY+=($( compgen -W         "$( { LC_ALL=C ifconfig -a || ip addr show; } 2>/dev/null |
            sed -ne 's/.*addr:\([^[:space:]]*\).*/\1/p'                 -ne 's|.*inet[[:space:]]\{1,\}\([^[:space:]/]*\).*|\1|p' )"         -- "$cur" ))
}
_is_integer () 
{ 
    [ "$1" -eq "$1" ] > /dev/null 2>&1;
    return $?
}
_kernel_versions () 
{ 
    COMPREPLY=($( compgen -W '$( command ls /lib/modules )' -- "$cur" ))
}
_kernels () 
{ 
    COMPREPLY=($( cd /lib/modules && compgen -d -- "$cur" ))
}
_known_hosts () 
{ 
    local cur prev words cword;
    _init_completion -n : || return;
    local options;
    [[ "$1" == -a || "$2" == -a ]] && options=-a;
    [[ "$1" == -c || "$2" == -c ]] && options+=" -c";
    _known_hosts_real $options -- "$cur"
}
_known_hosts_real () 
{ 
    local configfile flag prefix;
    local cur curd awkcur user suffix aliases i host;
    local -a kh khd config;
    local OPTIND=1;
    while getopts "acF:p:" flag "$@"; do
        case $flag in 
            a)
                aliases='yes'
            ;;
            c)
                suffix=':'
            ;;
            F)
                configfile=$OPTARG
            ;;
            p)
                prefix=$OPTARG
            ;;
        esac;
    done;
    [[ $# -lt $OPTIND ]] && echo "error: $FUNCNAME: missing mandatory argument CWORD";
    cur=${!OPTIND};
    let "OPTIND += 1";
    [[ $# -ge $OPTIND ]] && echo "error: $FUNCNAME("$@"): unprocessed arguments:" $(while [[ $# -ge $OPTIND ]]; do printf '%s\n' ${!OPTIND}; shift; done);
    [[ $cur == *@* ]] && user=${cur%@*}@ && cur=${cur#*@};
    kh=();
    if [[ -n $configfile ]]; then
        [[ -r $configfile ]] && config+=("$configfile");
    else
        for i in /etc/ssh/ssh_config ~/.ssh/config ~/.ssh2/config;
        do
            [[ -r $i ]] && config+=("$i");
        done;
    fi;
    if [[ ${#config[@]} -gt 0 ]]; then
        local OIFS=$IFS IFS='
' j;
        local -a tmpkh;
        tmpkh=($( awk 'sub("^[ \t]*([Gg][Ll][Oo][Bb][Aa][Ll]|[Uu][Ss][Ee][Rr])[Kk][Nn][Oo][Ww][Nn][Hh][Oo][Ss][Tt][Ss][Ff][Ii][Ll][Ee][ \t]+", "") { print $0 }' "${config[@]}" | sort -u ));
        IFS=$OIFS;
        for i in "${tmpkh[@]}";
        do
            while [[ $i =~ ^([^\"]*)\"([^\"]*)\"(.*)$ ]]; do
                i=${BASH_REMATCH[1]}${BASH_REMATCH[3]};
                j=${BASH_REMATCH[2]};
                __expand_tilde_by_ref j;
                [[ -r $j ]] && kh+=("$j");
            done;
            for j in $i;
            do
                __expand_tilde_by_ref j;
                [[ -r $j ]] && kh+=("$j");
            done;
        done;
    fi;
    if [[ -z $configfile ]]; then
        for i in /etc/ssh/ssh_known_hosts /etc/ssh/ssh_known_hosts2 /etc/known_hosts /etc/known_hosts2 ~/.ssh/known_hosts ~/.ssh/known_hosts2;
        do
            [[ -r $i ]] && kh+=("$i");
        done;
        for i in /etc/ssh2/knownhosts ~/.ssh2/hostkeys;
        do
            [[ -d $i ]] && khd+=("$i"/*pub);
        done;
    fi;
    if [[ ${#kh[@]} -gt 0 || ${#khd[@]} -gt 0 ]]; then
        awkcur=${cur//\//\\\/};
        awkcur=${awkcur//\./\\\.};
        curd=$awkcur;
        if [[ "$awkcur" == [0-9]*[.:]* ]]; then
            awkcur="^$awkcur[.:]*";
        else
            if [[ "$awkcur" == [0-9]* ]]; then
                awkcur="^$awkcur.*[.:]";
            else
                if [[ -z $awkcur ]]; then
                    awkcur="[a-z.:]";
                else
                    awkcur="^$awkcur";
                fi;
            fi;
        fi;
        if [[ ${#kh[@]} -gt 0 ]]; then
            COMPREPLY+=($( awk 'BEGIN {FS=","}
            /^\s*[^|\#]/ {
            sub("^@[^ ]+ +", ""); \
            sub(" .*$", ""); \
            for (i=1; i<=NF; ++i) { \
            sub("^\\[", "", $i); sub("\\](:[0-9]+)?$", "", $i); \
            if ($i !~ /[*?]/ && $i ~ /'"$awkcur"'/) {print $i} \
            }}' "${kh[@]}" 2>/dev/null ));
        fi;
        if [[ ${#khd[@]} -gt 0 ]]; then
            for i in "${khd[@]}";
            do
                if [[ "$i" == *key_22_$curd*.pub && -r "$i" ]]; then
                    host=${i/#*key_22_/};
                    host=${host/%.pub/};
                    COMPREPLY+=($host);
                fi;
            done;
        fi;
        for ((i=0; i < ${#COMPREPLY[@]}; i++ ))
        do
            COMPREPLY[i]=$prefix$user${COMPREPLY[i]}$suffix;
        done;
    fi;
    if [[ ${#config[@]} -gt 0 && -n "$aliases" ]]; then
        local hosts=$( sed -ne 's/^[ \t]*[Hh][Oo][Ss][Tt]\([Nn][Aa][Mm][Ee]\)\{0,1\}['"$'\t '"']\{1,\}\([^#*?]*\)\(#.*\)\{0,1\}$/\2/p' "${config[@]}" );
        COMPREPLY+=($( compgen -P "$prefix$user"             -S "$suffix" -W "$hosts" -- "$cur" ));
    fi;
    COMPREPLY+=($( compgen -W         "$( ruptime 2>/dev/null | awk '!/^ruptime:/ { print $1 }' )"         -- "$cur" ));
    if [[ -n ${COMP_KNOWN_HOSTS_WITH_HOSTFILE-1} ]]; then
        COMPREPLY+=($( compgen -A hostname -P "$prefix$user" -S "$suffix" -- "$cur" ));
    fi;
    __ltrim_colon_completions "$prefix$user$cur";
    return 0
}
_loexp_ () 
{ 
    local c=${COMP_WORDS[COMP_CWORD]};
    local a="${COMP_LINE}";
    local e s g=0 cd dc t="";
    local IFS;
    shopt -q extglob && g=1;
    test $g -eq 0 && shopt -s extglob;
    cd='*-?(c)d*';
    dc='*-d?(c)*';
    case "${1##*/}" in 
        libreoffice)
            e='!*.+(sxd|SXD|std|STD|dxf|DXF|emf|EMF|eps|EPS|met|MET|pct|PCT|sgf|SGF|sgv|SGV|sda|SDA|sdd|SDD|vor|VOR|svm|SVM|wmf|WMF|bmp|BMP|gif|GIF|jpg|JPG|jpeg|JPEG|jfif|JFIF|fif|FIF|jpe|JPE|pcd|PCD|pcx|PCX|pgm|PGM|png|PNG|ppm|PPM|psd|PSD|ras|RAS|tga|TGA|tif|TIF|tiff|TIFF|xbm|XBM|xpm|XPM|odg|ODG|otg|OTG|fodg|FODG|odc|ODC|odi|ODI|sds|SDS|wpg|WPG|svg|SVG|vdx|VDX|vsd|VSD|vsdm|VSDM|vsdx|VSDX|doc|DOC|dot|DOT|rtf|RTF|sxw|SXW|stw|STW|sdw|SDW|vor|VOR|txt|TXT|htm?|HTM?|xml|XML|wp|WP|wpd|WPD|wps|WPS|odt|ODT|ott|OTT|fodt|FODT|docm|DOCM|docx|DOCX|dotm|DOTM|dotx|DOTX|sxm|SXM|smf|SMF|mml|MML|odf|ODF|sxi|SXI|sti|STI|ppt|PPT|pps|PPS|pot|POT|sxd|SXD|sda|SDA|sdd|SDD|sdp|SDP|vor|VOR|cgm|CGM|odp|ODP|otp|OTP|fodp|FODP|ppsm|PPSM|ppsx|PPSX|pptm|PPTM|pptx|PPTX|potm|POTM|potx|POTX|odb|ODB|sxc|SXC|stc|STC|dif|DIF|dbf|DBF|xls|XLS|xlw|XLW|xlt|XLT|rtf|RTF|sdc|SDC|vor|VOR|slk|SLK|txt|TXT|htm|HTM|html|HTML|wk1|WK1|wks|WKS|123|123|xml|XML|ods|ODS|ots|OTS|fods|FODS|csv|CSV|xlsb|XLSB|xlsm|XLSM|xlsx|XLSX|xltm|XLTM|xltx|XLTX|sxg|SXG|odm|ODM|sgl|SGL|stw|STW|dot|DOT|vor|VOR|stc|STC|xlt|XLT|sti|STI|pot|POT|std|STD|stw|STW|dotm|DOTM|dotx|DOTX|potm|POTM|potx|POTX|xltm|XLTM|xltx|XLTX|htm|HTM|html|HTML|stw|STW|txt|TXT|vor|VOR|oth|OTH)'
        ;;
        loffice)
            e='!*.+(sxd|SXD|std|STD|dxf|DXF|emf|EMF|eps|EPS|met|MET|pct|PCT|sgf|SGF|sgv|SGV|sda|SDA|sdd|SDD|vor|VOR|svm|SVM|wmf|WMF|bmp|BMP|gif|GIF|jpg|JPG|jpeg|JPEG|jfif|JFIF|fif|FIF|jpe|JPE|pcd|PCD|pcx|PCX|pgm|PGM|png|PNG|ppm|PPM|psd|PSD|ras|RAS|tga|TGA|tif|TIF|tiff|TIFF|xbm|XBM|xpm|XPM|odg|ODG|otg|OTG|fodg|FODG|odc|ODC|odi|ODI|sds|SDS|wpg|WPG|svg|SVG|vdx|VDX|vsd|VSD|vsdm|VSDM|vsdx|VSDX|doc|DOC|dot|DOT|rtf|RTF|sxw|SXW|stw|STW|sdw|SDW|vor|VOR|txt|TXT|htm?|HTM?|xml|XML|wp|WP|wpd|WPD|wps|WPS|odt|ODT|ott|OTT|fodt|FODT|docm|DOCM|docx|DOCX|dotm|DOTM|dotx|DOTX|sxm|SXM|smf|SMF|mml|MML|odf|ODF|sxi|SXI|sti|STI|ppt|PPT|pps|PPS|pot|POT|sxd|SXD|sda|SDA|sdd|SDD|sdp|SDP|vor|VOR|cgm|CGM|odp|ODP|otp|OTP|fodp|FODP|ppsm|PPSM|ppsx|PPSX|pptm|PPTM|pptx|PPTX|potm|POTM|potx|POTX|odb|ODB|sxc|SXC|stc|STC|dif|DIF|dbf|DBF|xls|XLS|xlw|XLW|xlt|XLT|rtf|RTF|sdc|SDC|vor|VOR|slk|SLK|txt|TXT|htm|HTM|html|HTML|wk1|WK1|wks|WKS|123|123|xml|XML|ods|ODS|ots|OTS|fods|FODS|csv|CSV|xlsb|XLSB|xlsm|XLSM|xlsx|XLSX|xltm|XLTM|xltx|XLTX|sxg|SXG|odm|ODM|sgl|SGL|stw|STW|dot|DOT|vor|VOR|stc|STC|xlt|XLT|sti|STI|pot|POT|std|STD|stw|STW|dotm|DOTM|dotx|DOTX|potm|POTM|potx|POTX|xltm|XLTM|xltx|XLTX|htm|HTM|html|HTML|stw|STW|txt|TXT|vor|VOR|oth|OTH)'
        ;;
        loimpress)
            e='!*.+(sxi|SXI|sti|STI|ppt|PPT|pps|PPS|pot|POT|sxd|SXD|sda|SDA|sdd|SDD|sdp|SDP|vor|VOR|cgm|CGM|odp|ODP|otp|OTP|fodp|FODP|ppsm|PPSM|ppsx|PPSX|pptm|PPTM|pptx|PPTX|potm|POTM|potx|POTX)'
        ;;
        unopkg)
            e='!*.+(oxt|OXT)'
        ;;
        localc)
            e='!*.+(sxc|SXC|stc|STC|dif|DIF|dbf|DBF|xls|XLS|xlw|XLW|xlt|XLT|rtf|RTF|sdc|SDC|vor|VOR|slk|SLK|txt|TXT|htm|HTM|html|HTML|wk1|WK1|wks|WKS|123|123|xml|XML|ods|ODS|ots|OTS|fods|FODS|csv|CSV|xlsb|XLSB|xlsm|XLSM|xlsx|XLSX|xltm|XLTM|xltx|XLTX)'
        ;;
        loweb)
            e='!*.+(htm|HTM|html|HTML|stw|STW|txt|TXT|vor|VOR|oth|OTH)'
        ;;
        lofromtemplate)
            e='!*.+(stw|STW|dot|DOT|vor|VOR|stc|STC|xlt|XLT|sti|STI|pot|POT|std|STD|stw|STW|dotm|DOTM|dotx|DOTX|potm|POTM|potx|POTX|xltm|XLTM|xltx|XLTX)'
        ;;
        lomath)
            e='!*.+(sxm|SXM|smf|SMF|mml|MML|odf|ODF)'
        ;;
        lodraw)
            e='!*.+(sxd|SXD|std|STD|dxf|DXF|emf|EMF|eps|EPS|met|MET|pct|PCT|sgf|SGF|sgv|SGV|sda|SDA|sdd|SDD|vor|VOR|svm|SVM|wmf|WMF|bmp|BMP|gif|GIF|jpg|JPG|jpeg|JPEG|jfif|JFIF|fif|FIF|jpe|JPE|pcd|PCD|pcx|PCX|pgm|PGM|png|PNG|ppm|PPM|psd|PSD|ras|RAS|tga|TGA|tif|TIF|tiff|TIFF|xbm|XBM|xpm|XPM|odg|ODG|otg|OTG|fodg|FODG|odc|ODC|odi|ODI|sds|SDS|wpg|WPG|svg|SVG|vdx|VDX|vsd|VSD|vsdm|VSDM|vsdx|VSDX)'
        ;;
        lowriter)
            e='!*.+(doc|DOC|dot|DOT|rtf|RTF|sxw|SXW|stw|STW|sdw|SDW|vor|VOR|txt|TXT|htm?|HTM?|xml|XML|wp|WP|wpd|WPD|wps|WPS|odt|ODT|ott|OTT|fodt|FODT|docm|DOCM|docx|DOCX|dotm|DOTM|dotx|DOTX|sxg|SXG|odm|ODM|sgl|SGL)'
        ;;
        lobase)
            e='!*.+(odb|ODB)'
        ;;
        *)
            e='!*'
        ;;
    esac;
    case "$(complete -p ${1##*/} 2> /dev/null)" in 
        *-d*)

        ;;
        *)
            s="-S/"
        ;;
    esac;
    IFS='
';
    case "$c" in 
        \$\(*\))
            eval COMPREPLY=\(${c}\)
        ;;
        \$\(*)
            COMPREPLY=($(compgen -c -P '$(' -S ')'  -- ${c#??}))
        ;;
        \`*\`)
            eval COMPREPLY=\(${c}\)
        ;;
        \`*)
            COMPREPLY=($(compgen -c -P '\`' -S '\`' -- ${c#?}))
        ;;
        \$\{*\})
            eval COMPREPLY=\(${c}\)
        ;;
        \$\{*)
            COMPREPLY=($(compgen -v -P '${' -S '}'  -- ${c#??}))
        ;;
        \$*)
            COMPREPLY=($(compgen -v -P '$'          -- ${c#?}))
        ;;
        \~*/*)
            COMPREPLY=($(compgen -f -X "$e"         -- ${c}))
        ;;
        \~*)
            COMPREPLY=($(compgen -u ${s}	 	-- ${c}))
        ;;
        *@*)
            COMPREPLY=($(compgen -A hostname -P '@' -S ':' -- ${c#*@}))
        ;;
        *[*?[]*)
            COMPREPLY=($(compgen -G "${c}"))
        ;;
        *[?*+\!@]\(*\)*)
            if test $g -eq 0; then
                COMPREPLY=($(compgen -f -X "$e" -- $c));
                test $g -eq 0 && shopt -u extglob;
                return;
            fi;
            COMPREPLY=($(compgen -G "${c}"))
        ;;
        *)
            if test "$c" = ".."; then
                COMPREPLY=($(compgen -d -X "$e" -S / ${_nosp} -- $c));
            else
                for s in $(compgen -f -X "$e" -- $c);
                do
                    if test -d $s; then
                        COMPREPLY=(${COMPREPLY[@]} $(compgen -f -X "$e" -S / -- $s));
                    else
                        if test -z "$t"; then
                            COMPREPLY=(${COMPREPLY[@]} $s);
                        else
                            case "$(file -b $s 2> /dev/null)" in 
                                $t)
                                    COMPREPLY=(${COMPREPLY[@]} $s)
                                ;;
                            esac;
                        fi;
                    fi;
                done;
            fi
        ;;
    esac;
    test $g -eq 0 && shopt -u extglob
}
_longopt () 
{ 
    local cur prev words cword split;
    _init_completion -s || return;
    case "${prev,,}" in 
        --help | --usage | --version)
            return 0
        ;;
        --*dir*)
            _filedir -d;
            return 0
        ;;
        --*file* | --*path*)
            _filedir;
            return 0
        ;;
        --+([-a-z0-9_]))
            local argtype=$( $1 --help 2>&1 | sed -ne                 "s|.*$prev\[\{0,1\}=[<[]\{0,1\}\([-A-Za-z0-9_]\{1,\}\).*|\1|p" );
            case ${argtype,,} in 
                *dir*)
                    _filedir -d;
                    return 0
                ;;
                *file* | *path*)
                    _filedir;
                    return 0
                ;;
            esac
        ;;
    esac;
    $split && return 0;
    if [[ "$cur" == -* ]]; then
        COMPREPLY=($( compgen -W "$( $1 --help 2>&1 |             sed -ne 's/.*\(--[-A-Za-z0-9]\{1,\}=\{0,1\}\).*/\1/p' | sort -u )"             -- "$cur" ));
        [[ $COMPREPLY == *= ]] && compopt -o nospace;
    else
        if [[ "$1" == @(mk|rm)dir ]]; then
            _filedir -d;
        else
            _filedir;
        fi;
    fi
}
_mac_addresses () 
{ 
    local re='\([A-Fa-f0-9]\{2\}:\)\{5\}[A-Fa-f0-9]\{2\}';
    local PATH="$PATH:/sbin:/usr/sbin";
    COMPREPLY+=($(         { LC_ALL=C ifconfig -a || ip link show; } 2>/dev/null | sed -ne         "s/.*[[:space:]]HWaddr[[:space:]]\{1,\}\($re\)[[:space:]].*/\1/p" -ne         "s/.*[[:space:]]HWaddr[[:space:]]\{1,\}\($re\)[[:space:]]*$/\1/p" -ne         "s|.*[[:space:]]\(link/\)\{0,1\}ether[[:space:]]\{1,\}\($re\)[[:space:]].*|\2|p" -ne         "s|.*[[:space:]]\(link/\)\{0,1\}ether[[:space:]]\{1,\}\($re\)[[:space:]]*$|\2|p"
        ));
    COMPREPLY+=($( { arp -an || ip neigh show; } 2>/dev/null | sed -ne         "s/.*[[:space:]]\($re\)[[:space:]].*/\1/p" -ne         "s/.*[[:space:]]\($re\)[[:space:]]*$/\1/p" ));
    COMPREPLY+=($( sed -ne         "s/^[[:space:]]*\($re\)[[:space:]].*/\1/p" /etc/ethers 2>/dev/null ));
    COMPREPLY=($( compgen -W '${COMPREPLY[@]}' -- "$cur" ));
    __ltrim_colon_completions "$cur"
}
_minimal () 
{ 
    local cur prev words cword split;
    _init_completion -s || return;
    $split && return;
    _filedir
}
_modules () 
{ 
    local modpath;
    modpath=/lib/modules/$1;
    COMPREPLY=($( compgen -W "$( command ls -RL $modpath 2>/dev/null |         sed -ne 's/^\(.*\)\.k\{0,1\}o\(\.[gx]z\)\{0,1\}$/\1/p' )" -- "$cur" ))
}
_msg_opts () 
{ 
    local arg pkgs pkgname msgname searchmsg path count opts;
    if [[ $1 =~ .+/.* ]]; then
        pkgname=${1%%/*};
        msgname=${1#*/};
        searchmsg=1;
    else
        pkgname=${1};
    fi;
    if [[ -z ${searchmsg} ]]; then
        pkgs=($(rospack list | grep "^${pkgname}"));
        count=0;
        opts="";
        for ((i = 0 ; i < ${#pkgs[@]} ; i=i+2 ))
        do
            if [[ -d ${pkgs[i+1]}/msg ]]; then
                opts="$opts ${pkgs[i]}/";
                pkgname=${pkgs[i]};
                count=$((count+1));
            fi;
        done;
        if [[ $count -gt 1 ]]; then
            echo $opts;
            return 0;
        fi;
    fi;
    path=$(rospack find ${pkgname} 2> /dev/null);
    if [ $? -eq 0 ] && [ -d ${path}/msg ]; then
        echo $(find -L ${path}/msg -maxdepth 1 -mindepth 1 -name *.msg ! -regex ".*/[.][^./].*" -print0 | tr '\000' '\n' | sed -e "s/.*\/\(.*\)\.msg/${pkgname}\/\1/g");
    fi
}
_ncpus () 
{ 
    local var=NPROCESSORS_ONLN;
    [[ $OSTYPE == *linux* ]] && var=_$var;
    local n=$( getconf $var 2>/dev/null );
    printf %s ${n:-1}
}
_parse_help () 
{ 
    eval local cmd=$( quote "$1" );
    local line;
    { 
        case $cmd in 
            -)
                cat
            ;;
            *)
                LC_ALL=C "$( dequote "$cmd" )" ${2:---help} 2>&1
            ;;
        esac
    } | while read -r line; do
        [[ $line == *([ '	'])-* ]] || continue;
        while [[ $line =~ ((^|[^-])-[A-Za-z0-9?][[:space:]]+)\[?[A-Z0-9]+\]? ]]; do
            line=${line/"${BASH_REMATCH[0]}"/"${BASH_REMATCH[1]}"};
        done;
        __parse_options "${line// or /, }";
    done
}
_parse_usage () 
{ 
    eval local cmd=$( quote "$1" );
    local line match option i char;
    { 
        case $cmd in 
            -)
                cat
            ;;
            *)
                LC_ALL=C "$( dequote "$cmd" )" ${2:---usage} 2>&1
            ;;
        esac
    } | while read -r line; do
        while [[ $line =~ \[[[:space:]]*(-[^]]+)[[:space:]]*\] ]]; do
            match=${BASH_REMATCH[0]};
            option=${BASH_REMATCH[1]};
            case $option in 
                -?(\[)+([a-zA-Z0-9?]))
                    for ((i=1; i < ${#option}; i++ ))
                    do
                        char=${option:i:1};
                        [[ $char != '[' ]] && printf '%s\n' -$char;
                    done
                ;;
                *)
                    __parse_options "$option"
                ;;
            esac;
            line=${line#*"$match"};
        done;
    done
}
_pci_ids () 
{ 
    COMPREPLY+=($( compgen -W         "$( PATH="$PATH:/sbin" lspci -n | awk '{print $3}')" -- "$cur" ))
}
_pgids () 
{ 
    COMPREPLY=($( compgen -W '$( command ps axo pgid= )' -- "$cur" ))
}
_pids () 
{ 
    COMPREPLY=($( compgen -W '$( command ps axo pid= )' -- "$cur" ))
}
_pnames () 
{ 
    COMPREPLY=($( compgen -X '<defunct>' -W '$( command ps axo command= | \
        sed -e "s/ .*//" -e "s:.*/::" -e "s/:$//" -e "s/^[[(-]//" \
            -e "s/[])]$//" | sort -u )' -- "$cur" ))
}
_quote_readline_by_ref () 
{ 
    if [ -z "$1" ]; then
        printf -v $2 %s "$1";
    else
        if [[ $1 == \'* ]]; then
            printf -v $2 %s "${1:1}";
        else
            if [[ $1 == \~* ]]; then
                printf -v $2 \~%q "${1:1}";
            else
                printf -v $2 %q "$1";
            fi;
        fi;
    fi;
    [[ ${!2} == *\\* ]] && printf -v $2 %s "${1//\\\\/\\}";
    [[ ${!2} == \$* ]] && eval $2=${!2}
}
_realcommand () 
{ 
    type -P "$1" > /dev/null && { 
        if type -p realpath > /dev/null; then
            realpath "$(type -P "$1")";
        else
            if type -p greadlink > /dev/null; then
                greadlink -f "$(type -P "$1")";
            else
                if type -p readlink > /dev/null; then
                    readlink -f "$(type -P "$1")";
                else
                    type -P "$1";
                fi;
            fi;
        fi
    }
}
_rl_enabled () 
{ 
    [[ "$( bind -v )" = *$1+([[:space:]])on* ]]
}
_rocon_app_complete_exe () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="add-repo compat index info install list list-repos update rawinfo remove-repo";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    fi
}
_root_command () 
{ 
    local PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin;
    local root_command=$1;
    _command
}
_ros_decode_path () 
{ 
    local rosname rosdir reldir last;
    rosvals=();
    if [[ -z $1 ]]; then
        return 0;
    fi;
    if [[ $1 =~ .+/.* ]]; then
        rosname=${1%%/*};
        reldir=/${1#*/};
        last=${reldir##*/};
        reldir=${reldir%/*}/;
    else
        rosname=$1;
        if [[ -z $2 || $2 != "forceeval" ]]; then
            rosvals=(${rosname});
            return 1;
        fi;
    fi;
    rosdir=$(_ros_location_find $rosname);
    if [[ $? != 0 ]]; then
        rosvals=(${rosname});
        return 1;
    fi;
    rosvals=(${rosname} ${rosdir} ${reldir} ${last})
}
_ros_list_locations () 
{ 
    local ROS_LOCATION_KEYS packages stacks;
    ROS_LOCATION_KEYS=$(echo $ROS_LOCATIONS | _rossed -e 's/([^:=]*)=([^:=]*)(:*[^=])*(:|$)/\1 /g');
    packages=$(export ROS_CACHE_TIMEOUT=-1.0 && rospack list-names);
    stacks=$(export ROS_CACHE_TIMEOUT=-1.0 && rosstack list-names);
    echo $packages $stacks log test_results $ROS_LOCATION_KEYS | tr ' ' '\n';
    return 0
}
_ros_list_packages () 
{ 
    local packages;
    packages=$(export ROS_CACHE_TIMEOUT=-1.0 && rospack list-names);
    echo $packages | tr ' ' '\n';
    return 0
}
_ros_list_stacks () 
{ 
    local stacks;
    stacks=$(export ROS_CACHE_TIMEOUT=-1.0 && rosstack list-names);
    echo $stacks | tr ' ' '\n';
    return 0
}
_ros_location_find () 
{ 
    local ROS_LOCATION_KEYS_ARR ROS_LOCATIONS_ARR loc;
    ROS_LOCATION_KEYS_ARR=($(echo $ROS_LOCATIONS | _rossed -e 's/([^:=]*)=([^:=]*)(:*[^=])*(:|$)/\1 /g'));
    ROS_LOCATIONS_ARR=($(echo $ROS_LOCATIONS | _rossed -e 's/([^:=]*)=([^:=]*)(:*[^=])*(:|$)/\2 /g' -e "s|~|$HOME|g"));
    for ((i = 0 ; i < ${#ROS_LOCATION_KEYS_ARR[@]} ; i++ ))
    do
        if [[ $1 == ${ROS_LOCATION_KEYS_ARR[$i]} ]]; then
            echo ${ROS_LOCATIONS_ARR[i]};
            return 0;
        fi;
    done;
    if [[ $1 == log ]]; then
        echo $(roslaunch-logs);
        return 0;
    else
        if [[ $1 == test_results ]]; then
            echo $(rosrun rosunit test_results_dir.py);
            return 0;
        fi;
    fi;
    loc=$(export ROS_CACHE_TIMEOUT=-1.0 && rospack find $1 2> /dev/null);
    if [[ $? != 0 ]]; then
        loc=$(export ROS_CACHE_TIMEOUT=-1.0 && rosstack find $1 2> /dev/null);
        if [[ $? != 0 ]]; then
            return 1;
        fi;
        echo $loc;
        return 0;
    fi;
    echo $loc;
    return 0
}
_ros_package_find () 
{ 
    local loc;
    loc=$(export ROS_CACHE_TIMEOUT=-1.0 && rospack find $1 2> /dev/null);
    if [[ $? != 0 ]]; then
        return 1;
    fi;
    echo $loc;
    return 0
}
_roscmd () 
{ 
    local pkgdir exepath opt catkin_package_libexec_dir opts;
    if [[ -n $CMAKE_PREFIX_PATH ]]; then
        catkin_package_libexec_dir=$(catkin_find --first-only --without-underlays --libexec $1 2> /dev/null);
    fi;
    pkgdir=$(_ros_package_find $1);
    if [[ -z $catkin_package_libexec_dir && -z $pkgdir ]]; then
        echo "Couldn't find package [$1]";
        return 1;
    fi;
    exepath=($(find -L $catkin_package_libexec_dir $pkgdir -name $2 -type f ! -regex .*/[.].* ! -regex .*$pkgdir\/build\/.* | uniq));
    if [[ ${#exepath[@]} == 0 ]]; then
        echo "That file does not exist in that package.";
        return 1;
    else
        if [[ ${#exepath[@]} -gt 1 ]]; then
            echo "You have chosen a non-unique filename, please pick one of the following:";
            select opt in ${exepath[@]};
            do
                echo $opt;
                break;
            done;
        else
            opt=${exepath[0]};
        fi;
    fi;
    arg=${opt}
}
_roscomplete () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    opts="$(_ros_list_packages) $(_ros_list_stacks)";
    IFS='
';
    COMPREPLY=($(compgen -W "${opts}" -- ${arg}));
    unset IFS
}
_roscomplete_exe () 
{ 
    local perm i prev_arg;
    if [[ $(uname) == Darwin ]]; then
        perm="+111";
    else
        perm="/111";
    fi;
    rosrun_args=("--prefix" "--debug");
    local start_arg=1;
    for ((i=1; i < ${#COMP_WORDS[*]}; i++ ))
    do
        arg="${COMP_WORDS[i]}";
        case ${arg} in 
            "--prefix" | "-p")
                start_arg=$((start_arg+1))
            ;;
            "--debug" | "-d")
                start_arg=$((start_arg+1))
            ;;
            *)
                if [[ $prev_arg == "--prefix" || $prev_arg == "-p" ]]; then
                    start_arg=$((start_arg+1));
                else
                    break;
                fi
            ;;
        esac;
        prev_arg="${arg}";
    done;
    local end_arg=$((${#COMP_WORDS[*]} - 1));
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $start_arg > $end_arg ]]; then
        COMPREPLY=($(compgen -c -- ${arg}));
    else
        if [[ $start_arg == $end_arg ]]; then
            if [[ ${arg} =~ \-.* ]]; then
                COMPREPLY=($(compgen -W "${rosrun_args[*]}" -- ${arg}));
            else
                _roscomplete_pkg "${arg}";
            fi;
        else
            if [[ $((start_arg+1)) == ${end_arg} ]]; then
                local pkg="${COMP_WORDS[start_arg]}";
                _roscomplete_find "-type f -perm $perm" "${pkg}" "${arg}";
            else
                _roscomplete_search_dir "-type f -perm $perm";
            fi;
        fi;
    fi
}
_roscomplete_file () 
{ 
    _roscomplete_search_dir "-type f ! -regex .*[.][oa]$"
}
_roscomplete_find () 
{ 
    local opts pkgdir catkin_package_libexec_dir;
    local perm=${1};
    local pkg=${2};
    local arg=${3};
    if [[ -n $CMAKE_PREFIX_PATH ]]; then
        catkin_package_libexec_dir=$(catkin_find --first-only --without-underlays --libexec ${pkg} 2> /dev/null);
    fi;
    pkgdir=$(_ros_package_find ${pkg});
    if [[ -n "$catkin_package_libexec_dir" || -n "$pkgdir" ]]; then
        opts=$(_rosfind -L $catkin_package_libexec_dir "$pkgdir" ${1} ! -regex ".*/[.][^./].*" ! -regex ".*$pkgdir\/build\/.*"  -print0 | tr '\000' '\n' | sed -e "s/.*\/\(.*\)/\1/g");
    else
        opts="";
    fi;
    IFS='
';
    COMPREPLY=($(compgen -W "${opts}" -- ${arg}));
    unset IFS
}
_roscomplete_launch () 
{ 
    arg="${COMP_WORDS[COMP_CWORD]}";
    COMPREPLY=();
    if [[ ${arg} =~ \-\-.* ]]; then
        COMPREPLY=(${COMPREPLY[@]} $(compgen -W "--files --args --nodes --find-node --child --local --screen --server_uri --run_id --wait --port --core --pid --dump-params --skip-log-check --ros-args" -- ${arg}));
    else
        _roscomplete_search_dir "( -type f -regex .*\.launch$ -o -type f -regex .*\.test$ )";
        if [[ $COMP_CWORD == 1 ]]; then
            COMPREPLY=($(compgen -o plusdirs -f -X "!*.launch" -- ${arg}) ${COMPREPLY[@]} $(compgen -o plusdirs -f -X "!*.test" -- ${arg}) ${COMPREPLY[@]});
        else
            if [[ ${#COMP_WORDS[@]} -ge 2 ]]; then
                ROSLAUNCH_COMPLETE=$(which roslaunch-complete);
                if [[ -x ${ROSLAUNCH_COMPLETE} ]]; then
                    _roslaunch_args=$(${ROSLAUNCH_COMPLETE} ${COMP_WORDS[@]:1:2} 2> /dev/null);
                    if [[ $? == 0 ]]; then
                        COMPREPLY=($(compgen -W "${_roslaunch_args}" -- "${arg}"));
                    fi;
                fi;
            fi;
        fi;
    fi
}
_roscomplete_node_transform () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    local cword=$COMP_CWORD;
    for a in $(seq $((COMP_CWORD-1)));
    do
        if [ -z "${COMP_WORDS[a]//-*}" ]; then
            ((cword--));
        fi;
    done;
    local words=(${COMP_WORDS[@]//-*});
    if [[ $cword == 3 ]]; then
        opts=`rostopic list 2> /dev/null`;
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $cword == 5 ]]; then
            opts=`rosmsg list 2> /dev/null`;
            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
        fi;
    fi
}
_roscomplete_pkg () 
{ 
    local arg=${1};
    local opts=$(_ros_list_packages);
    IFS='
';
    COMPREPLY=($(compgen -W "${opts}" -- ${arg}));
    unset IFS
}
_roscomplete_rosbag () 
{ 
    local opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="check compress decompress filter fix help info play record reindex";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ ${arg} =~ \-\-.* ]]; then
            case ${COMP_WORDS[1]} in 
                check)
                    opts="--genrules --append --noplugins --help"
                ;;
                compress | decompress)
                    opts="--output-dir --force --quiet --help"
                ;;
                filter)
                    opts="--print --help"
                ;;
                fix)
                    opts="--force --noplugins --help"
                ;;
                info)
                    opts="--yaml --key --freq --help"
                ;;
                play)
                    opts="--help --quiet --immediate --pause --queue --clock --hz --delay --rate --start --skip-empty --loop --keep-alive --try-future-version --topics --bags"
                ;;
                record)
                    opts="--help --all --regex --exclude --quiet --output-prefix --output-name --split --size --duration --buffsize --limit --node --bz2"
                ;;
                reindex)
                    opts="--help --force --quiet --output-dir"
                ;;
            esac;
            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
        fi;
    fi
}
_roscomplete_rosclean () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="check purge";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    fi
}
_roscomplete_rosconsole () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="get list set";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD == 2 ]]; then
            case ${COMP_WORDS[1]} in 
                get | set | list)
                    opts=$(rosnode list 2> /dev/null);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
            esac;
        else
            if [[ $COMP_CWORD == 3 ]]; then
                case ${COMP_WORDS[1]} in 
                    get | set)
                        opts=$(rosconsole list ${COMP_WORDS[2]} 2> /dev/null);
                        COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                    ;;
                esac;
            else
                if [[ $COMP_CWORD == 4 ]]; then
                    case ${COMP_WORDS[1]} in 
                        set)
                            opts="debug info warn error fatal";
                            COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                        ;;
                    esac;
                fi;
            fi;
        fi;
    fi
}
_roscomplete_roscreate_pkg () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD != 1 ]]; then
        opts=$(rospack list-names);
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    fi
}
_roscomplete_rosmake () 
{ 
    local arg;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    _roscomplete;
    if [[ ${arg} =~ \-\-.* ]]; then
        COMPREPLY=(${COMPREPLY[@]} $(compgen -W "--test-only --all --mark-installed --unmark-installed --robust --build-everything --specified-only --buildtest --buildtest1 --output --pre-clean --bootstrap --disable-logging --target --pjobs= --threads --profile --skip-blacklist --status-rate" -- ${arg}));
    fi
}
_roscomplete_rosmsg () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="show list md5 package packages";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD == 2 ]]; then
            case ${COMP_WORDS[1]} in 
                show | info | users | md5)
                    opts=$(_msg_opts ${COMP_WORDS[$COMP_CWORD]});
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                package)
                    opts=$(rospack list-names);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                packages | list)

                ;;
            esac;
        fi;
    fi
}
_roscomplete_rosnode () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="ping list info machine kill cleanup";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD == 2 ]]; then
            case ${COMP_WORDS[1]} in 
                info)
                    opts=$(rosnode list 2> /dev/null);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                ping | list | kill)
                    if [[ ${arg} =~ \-\-.* ]]; then
                        opts="--all --help";
                    else
                        opts=$(rosnode list 2> /dev/null);
                    fi;
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                machine)

                ;;
            esac;
        else
            case ${COMP_WORDS[1]} in 
                kill)
                    opts=$(rosnode list 2> /dev/null);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
            esac;
        fi;
    fi
}
_roscomplete_rospack () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="help find list list-names list-duplicates langs depends depends-manifests depends1 depends-indent depends-msgsrv depends-why rosdep rosdep0 vcs vcs0 depends-on depends-on1 export plugins cflags-only-I cflags-only-other libs-only-L libs-only-l libs-only-other profile";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        opts=$(rospack list-names);
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    fi
}
_roscomplete_rospair () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="echo list call type info";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD -ge 2 ]]; then
            if [[ ${arg} =~ \-\-.* ]]; then
                case ${COMP_WORDS[1]} in 
                    call)
                        COMPREPLY=($(compgen -W "--rate --once --file --latch" -- ${arg}))
                    ;;
                    echo)
                        COMPREPLY=($(compgen -W "--bag --filter --nostr --noarr --clear --all offset" -- ${arg}))
                    ;;
                    list)
                        COMPREPLY=($(compgen -W "--bag --verbose --host" -- ${arg}))
                    ;;
                esac;
            else
                case ${COMP_WORDS[1]} in 
                    type | info)
                        if [[ ${COMP_WORDS[$(( $COMP_CWORD - 1 ))]} == "-b" ]]; then
                            COMPREPLY=($(compgen -f -- ${arg}));
                        else
                            opts=`rostopic list 2> /dev/null`;
                            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
                        fi
                    ;;
                    call)
                        if [[ $COMP_CWORD == 2 ]]; then
                            opts=`rospair list 2> /dev/null`;
                            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
                        else
                            if [[ $COMP_CWORD == 3 ]]; then
                                type=`rospair type ${COMP_WORDS[2]} | sed -e 's/Pair//g'`;
                                opts=`rosmsg-proto msg 2> /dev/null -s ${type}Request`;
                                if [ 0 -eq $? ]; then
                                    COMPREPLY="$opts";
                                fi;
                            fi;
                        fi
                    ;;
                esac;
            fi;
        fi;
    fi
}
_roscomplete_rosparam () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="set get load dump delete list";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD == 2 ]]; then
            case ${COMP_WORDS[1]} in 
                set | get | delete | list)
                    opts=$(rosparam list 2> /dev/null);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                load | dump)
                    COMPREPLY=($(compgen -f -- ${arg}))
                ;;
            esac;
        else
            if [[ $COMP_CWORD == 3 ]]; then
                case ${COMP_WORDS[1]} in 
                    load | dump)
                        opts=$(rosparam list 2> /dev/null);
                        COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                    ;;
                esac;
            fi;
        fi;
    fi
}
_roscomplete_rosrun_transform () 
{ 
    if is_transform_node; then
        _roscomplete_node_transform;
    else
        eval "$_sav_transform_roscomplete_rosrun";
    fi
}
_roscomplete_rosservice () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="args call find info list type uri";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD == 2 ]]; then
            case ${COMP_WORDS[1]} in 
                args | call | info | list | type | uri)
                    opts=$(rosservice list 2> /dev/null);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                find)
                    opts=$(_srv_opts ${COMP_WORDS[$COMP_CWORD]});
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
            esac;
        else
            if [[ $COMP_CWORD == 3 ]]; then
                case ${COMP_WORDS[1]} in 
                    call)
                        type=$(rosservice type ${COMP_WORDS[2]});
                        opts=$(rosmsg-proto srv 2> /dev/null -s ${type});
                        if [ 0 -eq $? ]; then
                            COMPREPLY="$opts";
                        fi
                    ;;
                esac;
            fi;
        fi;
    fi
}
_roscomplete_rossrv () 
{ 
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="show list md5 package packages";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD == 2 ]]; then
            case ${COMP_WORDS[1]} in 
                show | users | md5)
                    opts=$(_srv_opts ${COMP_WORDS[$COMP_CWORD]});
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                package)
                    opts=$(rospack list-names);
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                ;;
                packages | list)

                ;;
            esac;
        fi;
    fi
}
_roscomplete_rostopic () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        opts="bw echo hz list pub type find info";
        COMPREPLY=($(compgen -W "$opts" -- ${arg}));
    else
        if [[ $COMP_CWORD -ge 2 ]]; then
            if [[ ${arg} =~ \-\-.* ]]; then
                case ${COMP_WORDS[1]} in 
                    pub)
                        COMPREPLY=($(compgen -W "--rate --once --file --latch" -- ${arg}))
                    ;;
                    bw)
                        COMPREPLY=($(compgen -W "--window" -- ${arg}))
                    ;;
                    echo)
                        COMPREPLY=($(compgen -W "--bag --filter --nostr --noarr --clear --all offset" -- ${arg}))
                    ;;
                    hz)
                        COMPREPLY=($(compgen -W "--window --filter" -- ${arg}))
                    ;;
                    list)
                        COMPREPLY=($(compgen -W "--bag --verbose --host" -- ${arg}))
                    ;;
                esac;
            else
                case ${COMP_WORDS[1]} in 
                    bw | echo | hz | list | type | info)
                        if [[ ${COMP_WORDS[$(( $COMP_CWORD - 1 ))]} == "-b" ]]; then
                            COMPREPLY=($(compgen -f -- ${arg}));
                        else
                            opts=$(rostopic list 2> /dev/null);
                            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
                        fi
                    ;;
                    find)
                        opts=$(_msg_opts ${COMP_WORDS[$COMP_CWORD]});
                        COMPREPLY=($(compgen -W "$opts" -- ${arg}))
                    ;;
                    pub)
                        local topic_pos type_pos msg_pos;
                        topic_pos=2;
                        type_pos=3;
                        msg_pos=4;
                        while [ $topic_pos -lt ${#COMP_WORDS[*]} ]; do
                            if [[ ${COMP_WORDS[$topic_pos]} =~ \-.* ]]; then
                                if [[ ${COMP_WORDS[$topic_pos]} == "-f" || ${COMP_WORDS[$topic_pos]} == "-r" ]]; then
                                    topic_pos=$((topic_pos + 1));
                                    type_pos=$((type_pos + 1));
                                    msg_pos=$((msg_pos + 1));
                                fi;
                                topic_pos=$((topic_pos + 1));
                                type_pos=$((type_pos + 1));
                                msg_pos=$((msg_pos + 1));
                            else
                                break;
                            fi;
                        done;
                        if [[ $COMP_CWORD == $topic_pos ]]; then
                            opts=$(rostopic list 2> /dev/null);
                            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
                        else
                            if [[ $COMP_CWORD == $type_pos ]]; then
                                opts=$(rostopic info ${COMP_WORDS[$COMP_CWORD-1]} 2> /dev/null | awk '/Type:/{print $2}');
                                if [ -z "$opts" ]; then
                                    opts=$(_msg_opts ${COMP_WORDS[$COMP_CWORD]});
                                fi;
                                COMPREPLY=($(compgen -W "$opts" -- ${arg}));
                            else
                                if [[ $COMP_CWORD == $msg_pos ]]; then
                                    opts=$(rosmsg-proto msg 2> /dev/null -s ${COMP_WORDS[$COMP_CWORD - 1]});
                                    if [ 0 -eq $? ]; then
                                        COMPREPLY="$opts";
                                    fi;
                                fi;
                            fi;
                        fi
                    ;;
                esac;
            fi;
        fi;
    fi
}
_roscomplete_roswtf () 
{ 
    local arg;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ ${arg} =~ \-\-.* ]]; then
        COMPREPLY=($(compgen -W "--all --no-plugins --offline" -- ${arg}));
    else
        if [[ $COMP_CWORD == 1 ]]; then
            COMPREPLY=($(compgen -o plusdirs -f -X "!*.launch" -- ${arg}));
        fi;
    fi
}
_roscomplete_search_dir () 
{ 
    local arg opts;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ $COMP_CWORD == 1 ]]; then
        _roscomplete_pkg "${arg}";
    else
        if [[ $COMP_CWORD == 2 ]]; then
            _roscomplete_find "${1}" "${COMP_WORDS[1]}" "${arg}";
        else
            arg=$(echo ${arg} | sed -e "s|~|$HOME|g");
            if [[ $arg =~ ^/*.+/.* ]]; then
                path=${arg%/*};
            else
                path=.;
            fi;
            if [[ -e ${path} ]]; then
                opts=$(find -L $path -maxdepth 1 -type d ! -regex ".*/[.][^./].*" ! -regex "^[.]/" -print0 | tr '\000' '\n' | sed -e "s/$/\//g" -e "s/^[.]\///g" -e "s/'/\\\\\'/g" -e "s/ /\\\\\ /g")'
'$(find -L $path -maxdepth 1 -type f ! -regex ".*/[.][^.]*" ! -regex "^[.]/" -print0 | tr '\000' '\n' | sed -e "s/^[.]\///g"  -e "s/'/\\\\\'/g" -e "s/ /\\\\\ /g");
            else
                opts="";
            fi;
            IFS='
';
            COMPREPLY=($(compgen -W "$opts" -- ${arg}));
            unset IFS;
            if [[ ${#COMPREPLY[*]} = 1 ]]; then
                newpath=${COMPREPLY[0]%/*};
                if [[ -d ${newpath} ]]; then
                    opts=$(find -L $newpath -maxdepth 1 -type d ! -regex ".*/[.][^./].*" ! -regex "^[.]/" -print0 | tr '\000' '\n' | sed -e "s/$/\//g" -e "s/^[.]\///g" -e "s/'/\\\\\'/g" -e "s/ /\\\\\ /g")'
'$(find -L $newpath -maxdepth 1 -type f ! -regex ".*/[.][^.]*" ! -regex "^[.]/" -print0 | tr '\000' '\n' | sed -e "s/^[.]\///g"  -e "s/'/\\\\\'/g" -e "s/ /\\\\\ /g");
                    IFS='
';
                    COMPREPLY=($(compgen -W "$opts" -- ${arg}));
                    unset IFS;
                fi;
            fi;
        fi;
    fi
}
_roscomplete_sub_dir () 
{ 
    local arg opts rosvals;
    COMPREPLY=();
    arg="${COMP_WORDS[COMP_CWORD]}";
    _ros_decode_path ${arg};
    if [[ -z ${rosvals[2]} ]]; then
        opts=$(_ros_list_locations);
        IFS='
';
        COMPREPLY=($(compgen -W "${opts}" -S / -- ${rosvals[0]}));
        unset IFS;
    else
        if [ -e ${rosvals[1]}${rosvals[2]} ]; then
            opts=$(find -L ${rosvals[1]}${rosvals[2]} -maxdepth 1 -mindepth 1 -type d ! -regex ".*/[.][^./].*" -print0 | tr '\000' '\n' | sed -e "s/.*\/\(.*\)/\1\//g");
        else
            opts='';
        fi;
        IFS='
';
        COMPREPLY=($(compgen -P ${rosvals[0]}${rosvals[2]} -W "${opts}" -- ${rosvals[3]}));
        unset IFS;
    fi
}
_roscomplete_test () 
{ 
    arg="${COMP_WORDS[COMP_CWORD]}";
    if [[ ${arg} =~ \-\-.* ]]; then
        COMPREPLY=(${COMPREPLY[@]} $(compgen -W "--bare --bare-limit --bare-name --pkgdir --package" -- ${arg}));
    else
        _roscomplete_search_dir "( -type f -regex .*\.launch$ -o -type f -regex .*\.test$ )";
        if [[ $COMP_CWORD == 1 ]]; then
            COMPREPLY=($(compgen -o plusdirs -f -X "!*.launch" -- ${arg}) ${COMPREPLY[@]} $(compgen -o plusdirs -f -X "!*.test" -- ${arg}) ${COMPREPLY[@]});
        fi;
    fi
}
_rosfind () 
{ 
    if [[ $(uname) == Darwin || $(uname) == FreeBSD ]]; then
        find -E "$@";
    else
        find "$@";
    fi
}
_rossed () 
{ 
    if [[ $(uname) == Darwin || $(uname) == FreeBSD ]]; then
        sed -E "$@";
    else
        sed -r "$@";
    fi
}
_service () 
{ 
    local cur prev words cword;
    _init_completion || return;
    [[ $cword -gt 2 ]] && return 0;
    if [[ $cword -eq 1 && $prev == ?(*/)service ]]; then
        _services;
        [[ -e /etc/mandrake-release ]] && _xinetd_services;
    else
        local sysvdirs;
        _sysvdirs;
        COMPREPLY=($( compgen -W '`sed -e "y/|/ /" \
            -ne "s/^.*\(U\|msg_u\)sage.*{\(.*\)}.*$/\2/p" \
            ${sysvdirs[0]}/${prev##*/} 2>/dev/null` start stop' -- "$cur" ));
    fi
}
_services () 
{ 
    local sysvdirs;
    _sysvdirs;
    local restore_nullglob=$(shopt -p nullglob);
    shopt -s nullglob;
    COMPREPLY=($( printf '%s\n' ${sysvdirs[0]}/!($_backup_glob|functions) ));
    $restore_nullglob;
    COMPREPLY+=($( systemctl list-units --full --all 2>/dev/null |         awk '$1 ~ /\.service$/ { sub("\\.service$", "", $1); print $1 }' ));
    COMPREPLY=($( compgen -W '${COMPREPLY[@]#${sysvdirs[0]}/}' -- "$cur" ))
}
_shells () 
{ 
    local shell rest;
    while read -r shell rest; do
        [[ $shell == /* && $shell == "$cur"* ]] && COMPREPLY+=($shell);
    done 2> /dev/null < /etc/shells
}
_signals () 
{ 
    local -a sigs=($( compgen -P "$1" -A signal "SIG${cur#$1}" ));
    COMPREPLY+=("${sigs[@]/#${1}SIG/${1}}")
}
_split_longopt () 
{ 
    if [[ "$cur" == --?*=* ]]; then
        prev="${cur%%?(\\)=*}";
        cur="${cur#*=}";
        return 0;
    fi;
    return 1
}
_srv_opts () 
{ 
    local arg pkgs pkgname srvname searchsrv path count opts;
    if [[ $1 =~ .+/.* ]]; then
        pkgname=${1%%/*};
        srvname=${1#*/};
        searchsrv=1;
    else
        pkgname=${1};
    fi;
    if [[ -z ${searchsrv} ]]; then
        pkgs=($(rospack list | grep "^${pkgname}"));
        count=0;
        opts="";
        for ((i = 0 ; i < ${#pkgs[@]} ; i=i+2 ))
        do
            if [[ -d ${pkgs[i+1]}/srv ]]; then
                opts="$opts ${pkgs[i]}/";
                pkgname=${pkgs[i]};
                count=$((count+1));
            fi;
        done;
        if [[ $count -gt 1 ]]; then
            echo $opts;
            return 0;
        fi;
    fi;
    path=$(rospack find ${pkgname} 2> /dev/null);
    if [ $? -eq 0 ] && [ -d ${path}/srv ]; then
        echo $(find -L ${path}/srv -maxdepth 1 -mindepth 1 -name *.srv ! -regex ".*/[.][^./].*" -print0 | tr '\000' '\n' | sed -e "s/.*\/\(.*\)\.srv/${pkgname}\/\1/g");
    fi
}
_subdirectories () 
{ 
    COMPREPLY=($( cd $1 && compgen -d -- "$cur" ))
}
_sysvdirs () 
{ 
    sysvdirs=();
    [[ -d /etc/rc.d/init.d ]] && sysvdirs+=(/etc/rc.d/init.d);
    [[ -d /etc/init.d ]] && sysvdirs+=(/etc/init.d);
    [[ -f /etc/slackware-version ]] && sysvdirs=(/etc/rc.d)
}
_terms () 
{ 
    COMPREPLY+=($( compgen -W         "$( sed -ne 's/^\([^[:space:]#|]\{2,\}\)|.*/\1/p' /etc/termcap             2>/dev/null )" -- "$cur" ));
    COMPREPLY+=($( compgen -W "$( { toe -a 2>/dev/null || toe 2>/dev/null; }         | awk '{ print $1 }' | sort -u )" -- "$cur" ))
}
_tilde () 
{ 
    local result=0;
    if [[ $1 == \~* && $1 != */* ]]; then
        COMPREPLY=($( compgen -P '~' -u "${1#\~}" ));
        result=${#COMPREPLY[@]};
        [[ $result -gt 0 ]] && compopt -o filenames 2> /dev/null;
    fi;
    return $result
}
_uids () 
{ 
    if type getent &> /dev/null; then
        COMPREPLY=($( compgen -W '$( getent passwd | cut -d: -f3 )' -- "$cur" ));
    else
        if type perl &> /dev/null; then
            COMPREPLY=($( compgen -W '$( perl -e '"'"'while (($uid) = (getpwent)[2]) { print $uid . "\n" }'"'"' )' -- "$cur" ));
        else
            COMPREPLY=($( compgen -W '$( cut -d: -f3 /etc/passwd )' -- "$cur" ));
        fi;
    fi
}
_upvar () 
{ 
    if unset -v "$1"; then
        if (( $# == 2 )); then
            eval $1=\"\$2\";
        else
            eval $1=\(\"\${@:2}\"\);
        fi;
    fi
}
_upvars () 
{ 
    if ! (( $# )); then
        echo "${FUNCNAME[0]}: usage: ${FUNCNAME[0]} [-v varname" "value] | [-aN varname [value ...]] ..." 1>&2;
        return 2;
    fi;
    while (( $# )); do
        case $1 in 
            -a*)
                [[ -n ${1#-a} ]] || { 
                    echo "bash: ${FUNCNAME[0]}: \`$1': missing" "number specifier" 1>&2;
                    return 1
                };
                printf %d "${1#-a}" &> /dev/null || { 
                    echo "bash:" "${FUNCNAME[0]}: \`$1': invalid number specifier" 1>&2;
                    return 1
                };
                [[ -n "$2" ]] && unset -v "$2" && eval $2=\(\"\${@:3:${1#-a}}\"\) && shift $((${1#-a} + 2)) || { 
                    echo "bash: ${FUNCNAME[0]}:" "\`$1${2+ }$2': missing argument(s)" 1>&2;
                    return 1
                }
            ;;
            -v)
                [[ -n "$2" ]] && unset -v "$2" && eval $2=\"\$3\" && shift 3 || { 
                    echo "bash: ${FUNCNAME[0]}: $1: missing" "argument(s)" 1>&2;
                    return 1
                }
            ;;
            *)
                echo "bash: ${FUNCNAME[0]}: $1: invalid option" 1>&2;
                return 1
            ;;
        esac;
    done
}
_usb_ids () 
{ 
    COMPREPLY+=($( compgen -W         "$( PATH="$PATH:/sbin" lsusb | awk '{print $6}' )" -- "$cur" ))
}
_user_at_host () 
{ 
    local cur prev words cword;
    _init_completion -n : || return;
    if [[ $cur == *@* ]]; then
        _known_hosts_real "$cur";
    else
        COMPREPLY=($( compgen -u -- "$cur" ));
    fi;
    return 0
}
_usergroup () 
{ 
    if [[ $cur = *\\\\* || $cur = *:*:* ]]; then
        return;
    else
        if [[ $cur = *\\:* ]]; then
            local prefix;
            prefix=${cur%%*([^:])};
            prefix=${prefix//\\};
            local mycur="${cur#*[:]}";
            if [[ $1 == -u ]]; then
                _allowed_groups "$mycur";
            else
                local IFS='
';
                COMPREPLY=($( compgen -g -- "$mycur" ));
            fi;
            COMPREPLY=($( compgen -P "$prefix" -W "${COMPREPLY[@]}" ));
        else
            if [[ $cur = *:* ]]; then
                local mycur="${cur#*:}";
                if [[ $1 == -u ]]; then
                    _allowed_groups "$mycur";
                else
                    local IFS='
';
                    COMPREPLY=($( compgen -g -- "$mycur" ));
                fi;
            else
                if [[ $1 == -u ]]; then
                    _allowed_users "$cur";
                else
                    local IFS='
';
                    COMPREPLY=($( compgen -u -- "$cur" ));
                fi;
            fi;
        fi;
    fi
}
_userland () 
{ 
    local userland=$( uname -s );
    [[ $userland == @(Linux|GNU/*) ]] && userland=GNU;
    [[ $userland == $1 ]]
}
_variables () 
{ 
    if [[ $cur =~ ^(\$\{?)([A-Za-z0-9_]*)$ ]]; then
        [[ $cur == *{* ]] && local suffix=} || local suffix=;
        COMPREPLY+=($( compgen -P ${BASH_REMATCH[1]} -S "$suffix" -v --             "${BASH_REMATCH[2]}" ));
        return 0;
    fi;
    return 1
}
_wstool_complete () 
{ 
    local cur cmds cmdOpts opt helpCmds optBase i;
    COMPREPLY=();
    cur=${COMP_WORDS[COMP_CWORD]};
    cmds=$_WSTOOL_BASE_COMMANDS;
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($( compgen -W "$cmds" -- $cur ));
        return 0;
    fi;
    helpCmds='help|--help|h|\?';
    if [[ ${COMP_WORDS[1]} != @@($helpCmds) ]] && [[ "$cur" != -* ]]; then
        case ${COMP_WORDS[1]} in 
            info | diff | di | status | st | remove | rm | update | up)
                cmdOpts=`wstool info --only=localname 2> /dev/null | sed 's,:, ,g'`;
                COMPREPLY=($( compgen -W "$cmdOpts" -- $cur ))
            ;;
            set)
                if [[ $COMP_CWORD -eq 2 ]]; then
                    cmdOpts=`wstool info --only=localname 2> /dev/null | sed 's,:, ,g'`;
                    COMPREPLY=($( compgen -W "$cmdOpts" -- $cur ));
                else
                    if [[ $COMP_CWORD -eq 3 ]]; then
                        cmdOpts=`wstool info ${COMP_WORDS[2]} --only=uri 2> /dev/null`;
                        COMPREPLY=($( compgen -W "$cmdOpts" -- $cur ));
                    else
                        if [[ ${COMP_WORDS[$(( $COMP_CWORD - 1 ))]} == "--version-new" ]]; then
                            cmdOpts=`wstool info ${COMP_WORDS[2]} --only=version 2> /dev/null|sed 's/,$//'`;
                            COMPREPLY=($( compgen -W "$cmdOpts" -- $cur ));
                        fi;
                    fi;
                fi
            ;;
        esac;
        return 0;
    fi;
    cmdOpts=;
    case ${COMP_WORDS[1]} in 
        status | st)
            cmdOpts="-t --target-workspace --untracked"
        ;;
        diff | di)
            cmdOpts="-t --target-workspace"
        ;;
        init)
            cmdOpts="-t --target-workspace --continue-on-error"
        ;;
        merge)
            cmdOpts="-t --target-workspace -y --confirm-all -r --merge-replace -k --merge-keep -a --merge-kill-append"
        ;;
        set)
            cmdOpts="-t --target-workspace --git --svn --bzr --hg --uri -v --version-new --detached -y --confirm"
        ;;
        remove | rm)
            cmdOpts="-t --target-workspace"
        ;;
        update | up)
            cmdOpts="-t --target-workspace  --delete-changed-uris --abort-changed-uris --backup-changed-uris"
        ;;
        snapshot)
            cmdOpts="-t --target-workspace"
        ;;
        info)
            cmdOpts="-t --target-workspace --data-only --no-pkg-path --pkg-path-only --only --yaml"
        ;;
        *)

        ;;
    esac;
    cmdOpts="$cmdOpts --help -h";
    for ((i=2; i<=$COMP_CWORD-1; ++i ))
    do
        opt=${COMP_WORDS[$i]};
        case $opt in 
            --*)
                optBase=${opt/=*/}
            ;;
            -*)
                optBase=${opt:0:2}
            ;;
        esac;
        cmdOpts=" $cmdOpts ";
        cmdOpts=${cmdOpts/ ${optBase} / };
        case $optBase in 
            -h)
                cmdOpts=${cmdOpts/ --help / }
            ;;
            --help)
                cmdOpts=${cmdOpts/ -h / }
            ;;
            -t)
                cmdOpts=${cmdOpts/ --target-workspace / }
            ;;
            --target-workspace)
                cmdOpts=${cmdOpts/ -t / }
            ;;
            --delete-changed-uris)
                cmdOpts=${cmdOpts/ --abort-changed-uris / };
                cmdOpts=${cmdOpts/ --backup-changed-uris / }
            ;;
            --abort-changed-uris)
                cmdOpts=${cmdOpts/ --delete-changed-uris / };
                cmdOpts=${cmdOpts/ --backup-changed-uris / }
            ;;
            --backup-changed-uris)
                cmdOpts=${cmdOpts/ --delete-changed-uris / };
                cmdOpts=${cmdOpts/ --abort-changed-uris  / }
            ;;
            --svn)
                cmdOpts=${cmdOpts/ --git / };
                cmdOpts=${cmdOpts/ --hg / };
                cmdOpts=${cmdOpts/ --bzr / };
                cmdOpts=${cmdOpts/ --detached / }
            ;;
            --git)
                cmdOpts=${cmdOpts/ --svn / };
                cmdOpts=${cmdOpts/ --hg / };
                cmdOpts=${cmdOpts/ --bzr / };
                cmdOpts=${cmdOpts/ --detached / }
            ;;
            --hg)
                cmdOpts=${cmdOpts/ --git / };
                cmdOpts=${cmdOpts/ --svn / };
                cmdOpts=${cmdOpts/ --bzr / };
                cmdOpts=${cmdOpts/ --detached / }
            ;;
            --bzr)
                cmdOpts=${cmdOpts/ --git / };
                cmdOpts=${cmdOpts/ --hg / };
                cmdOpts=${cmdOpts/ --svn / };
                cmdOpts=${cmdOpts/ --detached / }
            ;;
            --detached)
                cmdOpts=${cmdOpts/ --git / };
                cmdOpts=${cmdOpts/ --hg / };
                cmdOpts=${cmdOpts/ --bzr / };
                cmdOpts=${cmdOpts/ --svn / }
            ;;
            --merge-replace)
                cmdOpts=${cmdOpts/ --merge-keep / };
                cmdOpts=${cmdOpts/ --merge-kill-append / };
                cmdOpts=${cmdOpts/ -r / };
                cmdOpts=${cmdOpts/ -a / };
                cmdOpts=${cmdOpts/ -k / }
            ;;
            --merge-keep)
                cmdOpts=${cmdOpts/ --merge-replace / };
                cmdOpts=${cmdOpts/ --merge-kill-append / };
                cmdOpts=${cmdOpts/ -r / };
                cmdOpts=${cmdOpts/ -a / };
                cmdOpts=${cmdOpts/ -k / }
            ;;
            --merge-kill-append)
                cmdOpts=${cmdOpts/ --merge-keep / };
                cmdOpts=${cmdOpts/ --merge-replace / };
                cmdOpts=${cmdOpts/ -r / };
                cmdOpts=${cmdOpts/ -a / };
                cmdOpts=${cmdOpts/ -k / }
            ;;
            -r)
                cmdOpts=${cmdOpts/ --merge-keep / };
                cmdOpts=${cmdOpts/ --merge-kill-append / };
                cmdOpts=${cmdOpts/ --merge-replace / };
                cmdOpts=${cmdOpts/ -a / };
                cmdOpts=${cmdOpts/ -k / }
            ;;
            -a)
                cmdOpts=${cmdOpts/ --merge-keep / };
                cmdOpts=${cmdOpts/ --merge-kill-append / };
                cmdOpts=${cmdOpts/ --merge-replace / };
                cmdOpts=${cmdOpts/ -r / };
                cmdOpts=${cmdOpts/ -k / }
            ;;
            -k)
                cmdOpts=${cmdOpts/ --merge-keep / };
                cmdOpts=${cmdOpts/ --merge-kill-append / };
                cmdOpts=${cmdOpts/ --merge-replace / };
                cmdOpts=${cmdOpts/ -a / };
                cmdOpts=${cmdOpts/ -r / }
            ;;
        esac;
        if [[ $opt == @@($optsParam) ]]; then
            ((++i));
        fi;
    done;
    COMPREPLY=($( compgen -W "$cmdOpts" -- $cur ));
    return 0
}
_xfunc () 
{ 
    set -- "$@";
    local srcfile=$1;
    shift;
    declare -F $1 &> /dev/null || { 
        local compdir=./completions;
        [[ $BASH_SOURCE == */* ]] && compdir="${BASH_SOURCE%/*}/completions";
        . "$compdir/$srcfile"
    };
    "$@"
}
_xinetd_services () 
{ 
    local xinetddir=/etc/xinetd.d;
    if [[ -d $xinetddir ]]; then
        local restore_nullglob=$(shopt -p nullglob);
        shopt -s nullglob;
        local -a svcs=($( printf '%s\n' $xinetddir/!($_backup_glob) ));
        $restore_nullglob;
        COMPREPLY+=($( compgen -W '${svcs[@]#$xinetddir/}' -- "$cur" ));
    fi
}
command_not_found_handle () 
{ 
    if [ -x /usr/lib/command-not-found ]; then
        /usr/lib/command-not-found -- "$1";
        return $?;
    else
        if [ -x /usr/share/command-not-found/command-not-found ]; then
            /usr/share/command-not-found/command-not-found -- "$1";
            return $?;
        else
            printf "%s: command not found\n" "$1" 1>&2;
            return 127;
        fi;
    fi
}
dequote () 
{ 
    eval printf %s "$1" 2> /dev/null
}
is_transform_node () 
{ 
    local words=(${COMP_WORDS[@]//-*});
    [ ${#words[@]} -gt 2 ] && [ "${words[1]}" = "topic_tools" ] && [ "${words[2]}" = "transform" ]
}
quote () 
{ 
    local quoted=${1//\'/\'\\\'\'};
    printf "'%s'" "$quoted"
}
quote_readline () 
{ 
    local quoted;
    _quote_readline_by_ref "$1" ret;
    printf %s "$ret"
}
rosawesome () 
{ 
    alias megamaid='rosbag record';
    alias suck2blow='rosbag play';
    alias botherder=roscore
}
roscat () 
{ 
    local arg;
    if [[ $1 = "--help" ]] || [[ $# -ne 2 ]]; then
        echo -e "usage: roscat [package] [file]\n\nDisplay a file content within a package.";
        [[ $1 = "--help" ]] && return 0 || return 1;
    fi;
    _roscmd ${1} ${2};
    [ $? -eq 1 ] && return 1;
    if [[ -n ${arg} ]]; then
        if [[ -z $CATTER ]]; then
            cat ${arg};
        else
            $CATTER ${arg};
        fi;
    fi
}
roscd () 
{ 
    local rosvals;
    if [[ $1 = "--help" ]] || [[ $# -gt 1 ]]; then
        echo -e "usage: roscd package\n\nJump to target package.";
        return 0;
    fi;
    if [ -z $1 ]; then
        if [ ! -z $ROS_WORKSPACE ]; then
            cd ${ROS_WORKSPACE};
            return 0;
        fi;
        if [ ! -z $CMAKE_PREFIX_PATH ]; then
            IFS=":" read -a workspaces <<< "$CMAKE_PREFIX_PATH";
            for ws in "${workspaces[@]}";
            do
                if [ -f $ws/.catkin ]; then
                    cd ${ws};
                    return 0;
                fi;
            done;
        fi;
        echo -e "Neither ROS_WORKSPACE is set nor a catkin workspace is listed in CMAKE_PREFIX_PATH.  Please set ROS_WORKSPACE or source a catkin workspace to use roscd with no arguments.";
        return 1;
    fi;
    _ros_decode_path $1 forceeval;
    if [ $? != 0 ]; then
        echo "roscd: No such package/stack '$1'";
        return 1;
    else
        if [ -z $rosvals ]; then
            if [ -z $ROS_WORKSPACE ]; then
                echo -e "No ROS_WORKSPACE set.  Please set ROS_WORKSPACE to use roscd with no arguments.";
                return 1;
            fi;
            cd ${ROS_WORKSPACE};
            return 0;
        else
            cd ${rosvals[1]}${rosvals[2]}${rosvals[3]};
            return 0;
        fi;
    fi
}
roscp () 
{ 
    local arg;
    if [[ $1 = "--help" ]] || [[ $# -ne 3 ]]; then
        echo -e "usage: roscp package filename target\n\nCopy a file from a package to target location.";
        return 0;
    fi;
    _roscmd ${1} ${2};
    cp ${arg} ${3}
}
rosd () 
{ 
    if [[ $1 = "--help" ]]; then
        echo -e "usage: rosd\n\nDisplays the list of currently remembered directories with indexes.";
        return 0;
    fi;
    let count=0;
    for items in $(dirs);
    do
        echo $count $items;
        let count=$((count+1));
    done
}
rosed () 
{ 
    local arg;
    if [[ $1 = "--help" ]]; then
        echo -e "usage: rosed [package] [file]\n\nEdit a file within a package.";
        return 0;
    fi;
    _roscmd ${1} ${2};
    if [[ -n ${arg} ]]; then
        if [[ -z $EDITOR ]]; then
            vim ${arg};
        else
            $EDITOR ${arg};
        fi;
    fi
}
rosls () 
{ 
    local rosvals;
    if [[ $1 = "--help" ]]; then
        echo -e "usage: rosls [package]\n\nLists contents of a package directory.";
        return 0;
    fi;
    _ros_decode_path $1 forceeval;
    ls --color=auto ${rosvals[1]}${rosvals[2]}${rosvals[3]} $2
}
rospd () 
{ 
    if [[ $1 = "--help" ]]; then
        echo -e "usage: rospd\n\nLike pushd, also accepts indexes from rosd.";
        return 0;
    fi;
    if _is_integer $1; then
        pushd +$1 > /dev/null;
    else
        local rosvals;
        _ros_decode_path $1 forceeval;
        if [ $? != 0 ] && [[ $# -gt 0 ]]; then
            echo "rospd: No such package/stack '$1'";
            return 1;
        fi;
        pushd ${rosvals[1]}${rosvals[2]}${rosvals[3]} > /dev/null;
    fi;
    rosd
}
rospython () 
{ 
    local pkgname;
    if [[ $1 = "--help" ]]; then
        echo -e "usage: rospython [package] \n\nRun python loading package manifest first.";
        return 0;
    fi;
    if [[ -z $1 ]]; then
        if [[ -f ./manifest.xml ]]; then
            pkgname=$(basename $(pwd));
            python -i -c "import roslib; roslib.load_manifest('$pkgname')";
        else
            python;
        fi;
    else
        python -i -c "import roslib; roslib.load_manifest('$1')";
    fi
}
