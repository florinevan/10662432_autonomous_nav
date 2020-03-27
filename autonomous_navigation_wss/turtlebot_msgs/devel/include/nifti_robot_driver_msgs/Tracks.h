// Generated by gencpp from file nifti_robot_driver_msgs/Tracks.msg
// DO NOT EDIT!


#ifndef NIFTI_ROBOT_DRIVER_MSGS_MESSAGE_TRACKS_H
#define NIFTI_ROBOT_DRIVER_MSGS_MESSAGE_TRACKS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace nifti_robot_driver_msgs
{
template <class ContainerAllocator>
struct Tracks_
{
  typedef Tracks_<ContainerAllocator> Type;

  Tracks_()
    : left(0.0)
    , right(0.0)  {
    }
  Tracks_(const ContainerAllocator& _alloc)
    : left(0.0)
    , right(0.0)  {
  (void)_alloc;
    }



   typedef double _left_type;
  _left_type left;

   typedef double _right_type;
  _right_type right;





  typedef boost::shared_ptr< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> const> ConstPtr;

}; // struct Tracks_

typedef ::nifti_robot_driver_msgs::Tracks_<std::allocator<void> > Tracks;

typedef boost::shared_ptr< ::nifti_robot_driver_msgs::Tracks > TracksPtr;
typedef boost::shared_ptr< ::nifti_robot_driver_msgs::Tracks const> TracksConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace nifti_robot_driver_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'nav_msgs': ['/opt/ros/kinetic/share/nav_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'nifti_robot_driver_msgs': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs/src/nifti_robot_driver_msgs/msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'actionlib_msgs': ['/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
{
  static const char* value()
  {
    return "50c2436c38cded221d061b57126c4e40";
  }

  static const char* value(const ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x50c2436c38cded22ULL;
  static const uint64_t static_value2 = 0x1d061b57126c4e40ULL;
};

template<class ContainerAllocator>
struct DataType< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
{
  static const char* value()
  {
    return "nifti_robot_driver_msgs/Tracks";
  }

  static const char* value(const ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 left\n\
float64 right\n\
\n\
";
  }

  static const char* value(const ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.left);
      stream.next(m.right);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Tracks_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::nifti_robot_driver_msgs::Tracks_<ContainerAllocator>& v)
  {
    s << indent << "left: ";
    Printer<double>::stream(s, indent + "  ", v.left);
    s << indent << "right: ";
    Printer<double>::stream(s, indent + "  ", v.right);
  }
};

} // namespace message_operations
} // namespace ros

#endif // NIFTI_ROBOT_DRIVER_MSGS_MESSAGE_TRACKS_H
