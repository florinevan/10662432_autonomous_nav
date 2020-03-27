// Generated by gencpp from file trajectory_control_msgs/TrajectoryControlActionResult.msg
// DO NOT EDIT!


#ifndef TRAJECTORY_CONTROL_MSGS_MESSAGE_TRAJECTORYCONTROLACTIONRESULT_H
#define TRAJECTORY_CONTROL_MSGS_MESSAGE_TRAJECTORYCONTROLACTIONRESULT_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>
#include <actionlib_msgs/GoalStatus.h>
#include <trajectory_control_msgs/TrajectoryControlResult.h>

namespace trajectory_control_msgs
{
template <class ContainerAllocator>
struct TrajectoryControlActionResult_
{
  typedef TrajectoryControlActionResult_<ContainerAllocator> Type;

  TrajectoryControlActionResult_()
    : header()
    , status()
    , result()  {
    }
  TrajectoryControlActionResult_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , status(_alloc)
    , result(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef  ::actionlib_msgs::GoalStatus_<ContainerAllocator>  _status_type;
  _status_type status;

   typedef  ::trajectory_control_msgs::TrajectoryControlResult_<ContainerAllocator>  _result_type;
  _result_type result;





  typedef boost::shared_ptr< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> const> ConstPtr;

}; // struct TrajectoryControlActionResult_

typedef ::trajectory_control_msgs::TrajectoryControlActionResult_<std::allocator<void> > TrajectoryControlActionResult;

typedef boost::shared_ptr< ::trajectory_control_msgs::TrajectoryControlActionResult > TrajectoryControlActionResultPtr;
typedef boost::shared_ptr< ::trajectory_control_msgs::TrajectoryControlActionResult const> TrajectoryControlActionResultConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace trajectory_control_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'nav_msgs': ['/opt/ros/kinetic/share/nav_msgs/cmake/../msg'], 'nifti_robot_driver_msgs': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs/src/nifti_robot_driver_msgs/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'actionlib_msgs': ['/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg'], 'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'visualization_msgs': ['/opt/ros/kinetic/share/visualization_msgs/cmake/../msg'], 'trajectory_control_msgs': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs/src/trajectory_control_msgs/msg', '/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs/devel/share/trajectory_control_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
{
  static const char* value()
  {
    return "1539cd8d17435bb9eb218719c6a831b3";
  }

  static const char* value(const ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x1539cd8d17435bb9ULL;
  static const uint64_t static_value2 = 0xeb218719c6a831b3ULL;
};

template<class ContainerAllocator>
struct DataType< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
{
  static const char* value()
  {
    return "trajectory_control_msgs/TrajectoryControlActionResult";
  }

  static const char* value(const ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n\
\n\
Header header\n\
actionlib_msgs/GoalStatus status\n\
TrajectoryControlResult result\n\
\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
\n\
================================================================================\n\
MSG: actionlib_msgs/GoalStatus\n\
GoalID goal_id\n\
uint8 status\n\
uint8 PENDING         = 0   # The goal has yet to be processed by the action server\n\
uint8 ACTIVE          = 1   # The goal is currently being processed by the action server\n\
uint8 PREEMPTED       = 2   # The goal received a cancel request after it started executing\n\
                            #   and has since completed its execution (Terminal State)\n\
uint8 SUCCEEDED       = 3   # The goal was achieved successfully by the action server (Terminal State)\n\
uint8 ABORTED         = 4   # The goal was aborted during execution by the action server due\n\
                            #    to some failure (Terminal State)\n\
uint8 REJECTED        = 5   # The goal was rejected by the action server without being processed,\n\
                            #    because the goal was unattainable or invalid (Terminal State)\n\
uint8 PREEMPTING      = 6   # The goal received a cancel request after it started executing\n\
                            #    and has not yet completed execution\n\
uint8 RECALLING       = 7   # The goal received a cancel request before it started executing,\n\
                            #    but the action server has not yet confirmed that the goal is canceled\n\
uint8 RECALLED        = 8   # The goal received a cancel request before it started executing\n\
                            #    and was successfully cancelled (Terminal State)\n\
uint8 LOST            = 9   # An action client can determine that a goal is LOST. This should not be\n\
                            #    sent over the wire by an action server\n\
\n\
#Allow for the user to associate a string with GoalStatus for debugging\n\
string text\n\
\n\
\n\
================================================================================\n\
MSG: actionlib_msgs/GoalID\n\
# The stamp should store the time at which this goal was requested.\n\
# It is used by an action server when it tries to preempt all\n\
# goals that were requested before a certain time\n\
time stamp\n\
\n\
# The id provides a way to associate feedback and\n\
# result message with specific goal requests. The id\n\
# specified must be unique.\n\
string id\n\
\n\
\n\
================================================================================\n\
MSG: trajectory_control_msgs/TrajectoryControlResult\n\
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n\
# Define the result\n\
bool done\n\
";
  }

  static const char* value(const ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.status);
      stream.next(m.result);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct TrajectoryControlActionResult_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::trajectory_control_msgs::TrajectoryControlActionResult_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "status: ";
    s << std::endl;
    Printer< ::actionlib_msgs::GoalStatus_<ContainerAllocator> >::stream(s, indent + "  ", v.status);
    s << indent << "result: ";
    s << std::endl;
    Printer< ::trajectory_control_msgs::TrajectoryControlResult_<ContainerAllocator> >::stream(s, indent + "  ", v.result);
  }
};

} // namespace message_operations
} // namespace ros

#endif // TRAJECTORY_CONTROL_MSGS_MESSAGE_TRAJECTORYCONTROLACTIONRESULT_H
