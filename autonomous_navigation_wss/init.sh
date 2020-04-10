#!/bin/bash

NAV_WSS=~/10662432_autonomous_nav/autonomous_navigation_wss

#Add variable to the bashrc file
#echo "source ~/10662432_autonomous_nav/autonomous_navigation_wss/source_all.bash" >> ~/.bashrc

#Cmake turtlebot_msgs ws
cd $NAV_WSS/turtlebot_msgs
catkin_make
source $NAV_WSS/turtlebot_msgs/devel/setup.bash --extend

#Cmake turtlebot ws
cd $NAV_WSS/turtlebot
catkin_make
source devel/setup.bash

#Cmake turtlebot_interaction ws
cd $NAV_WSS/turtlebot_interaction
catkin_make
source devel/setup.bash

#Cmake turtlebot_simulation ws
cd $NAV_WSS/turtlebot_simulation
catkin build
source devel/setup.bash
cd src/vrep_ugv_plugin
./install.sh

#Cmake turtlebot_map_and_nav ws
cd $NAV_WSS/turtlebot_map_and_nav
catkin_make
source devel/setup.bash

#Cmake turtlebot_2dslam ws
cd $NAV_WSS/turtlebot_2dslam
catkin_make
source devel/setup.bash

#Cmake turtlebot_3d_nav
cd $NAV_WSS/turtlebot_3d_nav
catkin_make
source devel/setup.bash





