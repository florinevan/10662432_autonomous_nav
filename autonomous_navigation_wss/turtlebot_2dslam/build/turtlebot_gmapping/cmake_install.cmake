# Install script for directory: /home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam/src/turtlebot_gmapping

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam/build/turtlebot_gmapping/catkin_generated/installspace/turtlebot_gmapping.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/turtlebot_gmapping/cmake" TYPE FILE FILES
    "/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam/build/turtlebot_gmapping/catkin_generated/installspace/turtlebot_gmappingConfig.cmake"
    "/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam/build/turtlebot_gmapping/catkin_generated/installspace/turtlebot_gmappingConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/turtlebot_gmapping" TYPE FILE FILES "/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_2dslam/src/turtlebot_gmapping/package.xml")
endif()

