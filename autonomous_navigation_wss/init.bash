#!/bin/bash

NAV_WSS=~/10662432_autonomous_nav/autonomous_navigation_wss

#Install useful packages
sudo apt-get --assume-yes install python-catkin-tools
sudo apt-get --assume-yes install ros-kinetic-brics-actuator
sudo apt-get --assume-yes install terminator
sudo apt --assume-yes install xsltproc
sudo apt --assume-yes install tree
sudo apt-get --assume-yes install ros-kinetic-move-base
sudo apt-get --assume-yes install ros-kinetic-pointcloud-to-laserscan
sudo apt-get --assume-yes install ros-kinetic-slam-karto
sudo apt-get --assume-yes install ros-kinetic-hector-*
sudo apt-get --assume-yes install libopencv-dev
sudo apt-get --assume-yes install ros-kinetic-kobuki-description
sudo apt-get --assume-yes install pyqt4*
sudo apt-get --assume-yes install ros-kinetic-navigation*
sudo apt-get --assume-yes install ros-kinetic-dwa-local-planner
sudo apt-get --assume-yes install ros-kinetic-octomap

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
cd $NAV_WSS

#Cmake turtlebot_3d_nav
#cd $NAV_WSS/turtlebot_3d_nav
#catkin_make
#source devel/setup.bash


