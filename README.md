# ROCO506 Coursework 

Hello, 
This repository contains my **individual work** for the ROCO506 coursework. This file provides instructions on **how to install** and **how to run** my robotic application. 
Florine

# System requirements
This repository needs the following configuration: 
 - Ubuntu 16.04
 - VREP 3.2 
 - ROS kinetic
 
# How to install

First of all,  download the application repository on Git

    cd ~
    git clone https://github.com/florinevan/10662432_autonomous_nav.git
       
Execute the bash file provided in order to cmake all the workspaces and install useful packages

    cd ~/10662432_autonomous_nav/autonomous_navigation_wss/
    chmod 777 *.bash
    source init.bash
    
Once you've done this step, the application is ready to be run ! 

# How to run 


## 2D Simultaneous Localization and Mapping (SLAM)
The objective of this part is to build a 2D map of an unknown environment. Also, the robot should be able to localize itself within this map. The application has several 2D SLAM (Simultaneous Localization and Mapping) algorithms: gmapping, karto and hector. Each one corresponds to a specific bash file in the application repository. 

### Gmapping

> Information on Gmapping alogirthm: http://wiki.ros.org/gmapping

Gmapping package provides laser-based SLAM by subscribing to sensor_msgs/LaserScan topic in order to build a 2D map (published on nav_msgs/OccupancyGrid). To use Gmapping algorithm, execute the following commands: 

    cd ~/10662432_autonomous_nav/autonomous_navigation_wss/
    source 2dslam_gmapping.bash

### Slam karto

> Information on SLAM karto algorithm: http://wiki.ros.org/slam_karto

In the same way that Gmapping, SLAM karto node subscribes to sensor_msgs/LaserScan topic in order to build a 2D map (published on nav_msgs/OccupancyGrid). To use karto algorithm, execute the following commands:

    cd ~/10662432_autonomous_nav/autonomous_navigation_wss/
    source 2dslam_karto.bash

### Hector mapping

> Information on Hector mapping algorithm: http://wiki.ros.org/hector_mapping

Hector mapping can be used without odometry. It uses modern LIDAR system to provide 2D pose estimates. To use Hector algorithm, execute the following commands: 

    cd ~/10662432_autonomous_nav/autonomous_navigation_wss/
    source 2dslam_hector_mapping.bash
    
    
## Point-To-Point Path Planning (PTP-PP) on 2D Maps and control of the Turtlebot2 on the trajectories generated
The objective of this part is to be able to select a point on the map and to generate a path to it. To do that, we are going to use the gmapping algorithm to generate a 2D map and localize the robot on it. Also, we are going to set up a ROS navigation stack. The latter will publish odometry information and sensor data from a laser. 

> Information on navigation stack: http://wiki.ros.org/navigation/Tutorials/RobotSetup

Since the path has been generated, we want to make the robot move along it. The goal is to reduce at minimum the error between the current position and the expected position. Execute the following commands to run the application:

      cd ~/10662432_autonomous_nav/autonomous_navigation_wss/
      source control.bash

To draw a path on RVIZ, select "2D Nav Goal" cursor. On the enclosed video, when we draw a path, we can see 2 different paths: the first one is the expected one, i.g. the one drawn by the user, and the second one is the actual path followed by the robot. 

# How to test the application

## 2D SLAM
To test this part of the application, it could be interesting to move the robot (with the keyboard) throughout the map generated and observe how the map is drawn and how the robot is located on it. We can also compare the robot RVIZ position from its V-REP one. 

## PTP-PP on 2D maps
To test the PTP-PP, we can draw several path on RVIZ and see how the robot moves on it. We can notice that depending on the target point, the expected path is more or less different from the actual one. 
Blue sections represents obstacle, it means the robot won't go there. It is interesting for testing purposes to draw a path which goes to these obstacles and see what is happening. 

