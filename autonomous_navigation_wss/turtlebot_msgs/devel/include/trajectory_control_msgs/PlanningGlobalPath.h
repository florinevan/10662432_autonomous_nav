// Generated by gencpp from file trajectory_control_msgs/PlanningGlobalPath.msg
// DO NOT EDIT!


#ifndef TRAJECTORY_CONTROL_MSGS_MESSAGE_PLANNINGGLOBALPATH_H
#define TRAJECTORY_CONTROL_MSGS_MESSAGE_PLANNINGGLOBALPATH_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>
#include <geometry_msgs/Point.h>
#include <nav_msgs/Path.h>

namespace trajectory_control_msgs
{
template <class ContainerAllocator>
struct PlanningGlobalPath_
{
  typedef PlanningGlobalPath_<ContainerAllocator> Type;

  PlanningGlobalPath_()
    : header()
    , name()
    , task_id(0)
    , type(0)
    , waypoints()
    , path()  {
    }
  PlanningGlobalPath_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , name(_alloc)
    , task_id(0)
    , type(0)
    , waypoints(_alloc)
    , path(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _name_type;
  _name_type name;

   typedef int32_t _task_id_type;
  _task_id_type task_id;

   typedef uint8_t _type_type;
  _type_type type;

   typedef std::vector< ::geometry_msgs::Point_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::geometry_msgs::Point_<ContainerAllocator> >::other >  _waypoints_type;
  _waypoints_type waypoints;

   typedef  ::nav_msgs::Path_<ContainerAllocator>  _path_type;
  _path_type path;





  typedef boost::shared_ptr< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> const> ConstPtr;

}; // struct PlanningGlobalPath_

typedef ::trajectory_control_msgs::PlanningGlobalPath_<std::allocator<void> > PlanningGlobalPath;

typedef boost::shared_ptr< ::trajectory_control_msgs::PlanningGlobalPath > PlanningGlobalPathPtr;
typedef boost::shared_ptr< ::trajectory_control_msgs::PlanningGlobalPath const> PlanningGlobalPathConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bcb6b89f087c9569c38f6953756f6de0";
  }

  static const char* value(const ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xbcb6b89f087c9569ULL;
  static const uint64_t static_value2 = 0xc38f6953756f6de0ULL;
};

template<class ContainerAllocator>
struct DataType< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
{
  static const char* value()
  {
    return "trajectory_control_msgs/PlanningGlobalPath";
  }

  static const char* value(const ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
{
  static const char* value()
  {
    return "std_msgs/Header header\n\
string name                      # task name; a planning task is a vector of task-segments; a task-segment is composed by a start and a goal (two points). \n\
int32 task_id\n\
uint8  type                      # NORMAL=0, CYCLIC = 1\n\
geometry_msgs/Point[] waypoints  # array of waypoints\n\
nav_msgs/Path path               # the computed path which joins the waypoints \n\
\n\
\n\
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
MSG: geometry_msgs/Point\n\
# This contains the position of a point in free space\n\
float64 x\n\
float64 y\n\
float64 z\n\
\n\
================================================================================\n\
MSG: nav_msgs/Path\n\
#An array of poses that represents a Path for a robot to follow\n\
Header header\n\
geometry_msgs/PoseStamped[] poses\n\
\n\
================================================================================\n\
MSG: geometry_msgs/PoseStamped\n\
# A Pose with reference coordinate frame and timestamp\n\
Header header\n\
Pose pose\n\
\n\
================================================================================\n\
MSG: geometry_msgs/Pose\n\
# A representation of pose in free space, composed of position and orientation. \n\
Point position\n\
Quaternion orientation\n\
\n\
================================================================================\n\
MSG: geometry_msgs/Quaternion\n\
# This represents an orientation in free space in quaternion form.\n\
\n\
float64 x\n\
float64 y\n\
float64 z\n\
float64 w\n\
";
  }

  static const char* value(const ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.name);
      stream.next(m.task_id);
      stream.next(m.type);
      stream.next(m.waypoints);
      stream.next(m.path);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct PlanningGlobalPath_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::trajectory_control_msgs::PlanningGlobalPath_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.name);
    s << indent << "task_id: ";
    Printer<int32_t>::stream(s, indent + "  ", v.task_id);
    s << indent << "type: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.type);
    s << indent << "waypoints[]" << std::endl;
    for (size_t i = 0; i < v.waypoints.size(); ++i)
    {
      s << indent << "  waypoints[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::geometry_msgs::Point_<ContainerAllocator> >::stream(s, indent + "    ", v.waypoints[i]);
    }
    s << indent << "path: ";
    s << std::endl;
    Printer< ::nav_msgs::Path_<ContainerAllocator> >::stream(s, indent + "  ", v.path);
  }
};

} // namespace message_operations
} // namespace ros

#endif // TRAJECTORY_CONTROL_MSGS_MESSAGE_PLANNINGGLOBALPATH_H
