#!/bin/bash

NAV_WSS=~/10662432_autonomous_nav/autonomous_navigation_wss
VREP=~/Programs/V-REP_PRO_EDU_V3_6_2
EXIT=0

source source_all.bash

#Run roscore
gnome-terminal -e "roscore"

#Run V-REP 
gnome-terminal --working-directory=$VREP -e "./vrep.sh -s $NAV_WSS/turtlebot_simulation/src/vrep_simulation/scenes/turtlebot2_maze_scenario.ttt"

sleep 5

#Run RVIZ
gnome-terminal --working-directory=$NAV_WSS -e "roslaunch turtlebot_rviz_launchers vrep_turtlebot_rviz_launch.launch"

#Run 2D SLAM
gnome-terminal --working-directory=$NAV_WSS -e "roslaunch turtlebot_gmapping turtlebot_gmapping.launch"

#Run move base
gnome-terminal --working-directory=$NAV_WSS -e "roslaunch turtlebot_navigation turtlebot_move_base.launch"

echo Press key to quit
while [ $EXIT -lt 1 ]
do
	read q
	if [ q ]
	then
		TERMPID=$(ps -ef |grep roscore |head -1 |awk '{print $2}')
		kill $TERMPID
		TERMPID=$(ps -ef |grep vrep.sh |head -1 |awk '{print $2}')
		kill $TERMPID
		TERMPID=$(ps -ef |grep 'roslaunch turtlebot_rviz_launchers' |head -1 |awk '{print $2}')
		kill $TERMPID
		#TERMPID=$(ps -ef |grep 'roslaunch rgb_pcd_kinect_fusion' |head -1 |awk '{print $2}')
		#kill $TERMPID
		#TERMPID=$(ps -ef |grep 'roslaunch stigmergy_planner' |head -1 |awk '{print $2}')
		#kill $TERMPID
		TERMPID=$(ps -ef |grep 'roslaunch turtlebot_gmapping' |head -1 |awk '{print $2}')
		kill $TERMPID
		TERMPID=$(ps -ef |grep 'roslaunch turtlebot_navigation' |head -1 |awk '{print $2}')
		kill $TERMPID
		EXIT=$(( $EXIT + 1 ))
	fi
done
