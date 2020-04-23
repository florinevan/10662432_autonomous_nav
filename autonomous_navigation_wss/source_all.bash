#! /bin/bash 

TURTLEBOT_DRIVERS_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot
source $TURTLEBOT_DRIVERS_WS/devel/setup.bash --extend
 
TURTLEBOT_INTERACTION_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_interaction
source $TURTLEBOT_INTERACTION_WS/devel/setup.bash --extend
 
TURTLEBOT_MSGS_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs
source $TURTLEBOT_MSGS_WS/devel/setup.bash --extend

TURTLEBOT_SIMULATION_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_simulation
source $TURTLEBOT_SIMULATION_WS/devel/setup.bash --extend
  
TURTLEBOT_MAP_AND_NAV_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_map_and_nav
source $TURTLEBOT_MAP_AND_NAV_WS/devel/setup.bash --extend

TURTLEBOT_2DSLAM_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam
source $TURTLEBOT_2DSLAM_WS/devel/setup.bash --extend

#TURTLEBOT_3D_NAV_WS=~/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_3d_nav
#source $TURTLEBOT_3D_NAV_WS/devel/setup.bash --extend
