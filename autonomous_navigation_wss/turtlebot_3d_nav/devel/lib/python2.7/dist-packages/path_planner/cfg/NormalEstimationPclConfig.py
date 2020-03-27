## *********************************************************
##
## File autogenerated for the path_planner package
## by the dynamic_reconfigure package.
## Please do not edit.
##
## ********************************************************/

from dynamic_reconfigure.encoding import extract_params

inf = float('inf')

config_description = {'upper': 'DEFAULT', 'lower': 'groups', 'srcline': 245, 'name': 'Default', 'parent': 0, 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'cstate': 'true', 'parentname': 'Default', 'class': 'DEFAULT', 'field': 'default', 'state': True, 'parentclass': '', 'groups': [], 'parameters': [{'srcline': 290, 'description': 'Laser frame', 'max': '', 'cconsttype': 'const char * const', 'ctype': 'std::string', 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'laser_frame', 'edit_method': '', 'default': '/laser', 'level': 0, 'min': '', 'type': 'str'}, {'srcline': 290, 'description': 'Smoothing factor for the gaussian kernel', 'max': 5.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'smoothing', 'edit_method': '', 'default': 1.0, 'level': 0, 'min': 0.01, 'type': 'double'}, {'srcline': 290, 'description': 'Neighbor search radius', 'max': 1.5, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'radius', 'edit_method': '', 'default': 0.2, 'level': 0, 'min': 0.001, 'type': 'double'}, {'srcline': 290, 'description': 'Num. of threads', 'max': 50, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'num_threads', 'edit_method': '', 'default': 4, 'level': 0, 'min': 3, 'type': 'int'}, {'srcline': 290, 'description': 'Flatness curvature threshold', 'max': 1.0, 'cconsttype': 'const double', 'ctype': 'double', 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'flatness_curvature_threshold', 'edit_method': '', 'default': 0.2, 'level': 0, 'min': 0.001, 'type': 'double'}, {'srcline': 290, 'description': 'Kernel type', 'max': 1, 'cconsttype': 'const int', 'ctype': 'int', 'srcfile': '/opt/ros/kinetic/lib/python2.7/dist-packages/dynamic_reconfigure/parameter_generator_catkin.py', 'name': 'kernel_type', 'edit_method': "{'enum_description': 'Kernel type', 'enum': [{'srcline': 15, 'description': 'Gaussian', 'srcfile': '/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_3d_nav/src/path_planner/cfg/NormalEstimationPcl.cfg', 'cconsttype': 'const int', 'value': 0, 'ctype': 'int', 'type': 'int', 'name': 'Gaussian'}, {'srcline': 16, 'description': 'Cosine', 'srcfile': '/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_3d_nav/src/path_planner/cfg/NormalEstimationPcl.cfg', 'cconsttype': 'const int', 'value': 1, 'ctype': 'int', 'type': 'int', 'name': 'Cosine'}]}", 'default': 0, 'level': 0, 'min': 0, 'type': 'int'}], 'type': '', 'id': 0}

min = {}
max = {}
defaults = {}
level = {}
type = {}
all_level = 0

#def extract_params(config):
#    params = []
#    params.extend(config['parameters'])
#    for group in config['groups']:
#        params.extend(extract_params(group))
#    return params

for param in extract_params(config_description):
    min[param['name']] = param['min']
    max[param['name']] = param['max']
    defaults[param['name']] = param['default']
    level[param['name']] = param['level']
    type[param['name']] = param['type']
    all_level = all_level | param['level']

NormalEstimationPcl_Gaussian = 0
NormalEstimationPcl_Cosine = 1
