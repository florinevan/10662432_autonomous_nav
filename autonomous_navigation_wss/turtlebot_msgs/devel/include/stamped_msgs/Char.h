// Generated by gencpp from file stamped_msgs/Char.msg
// DO NOT EDIT!


#ifndef STAMPED_MSGS_MESSAGE_CHAR_H
#define STAMPED_MSGS_MESSAGE_CHAR_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace stamped_msgs
{
template <class ContainerAllocator>
struct Char_
{
  typedef Char_<ContainerAllocator> Type;

  Char_()
    : header()
    , data(0)  {
    }
  Char_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , data(0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef uint8_t _data_type;
  _data_type data;





  typedef boost::shared_ptr< ::stamped_msgs::Char_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::stamped_msgs::Char_<ContainerAllocator> const> ConstPtr;

}; // struct Char_

typedef ::stamped_msgs::Char_<std::allocator<void> > Char;

typedef boost::shared_ptr< ::stamped_msgs::Char > CharPtr;
typedef boost::shared_ptr< ::stamped_msgs::Char const> CharConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::stamped_msgs::Char_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::stamped_msgs::Char_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace stamped_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'stamped_msgs': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs/src/stamped_msgs/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::stamped_msgs::Char_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::stamped_msgs::Char_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::stamped_msgs::Char_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::stamped_msgs::Char_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::stamped_msgs::Char_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::stamped_msgs::Char_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::stamped_msgs::Char_<ContainerAllocator> >
{
  static const char* value()
  {
    return "5afacf670cd60dfcaaf6b7ff4f12ccd8";
  }

  static const char* value(const ::stamped_msgs::Char_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x5afacf670cd60dfcULL;
  static const uint64_t static_value2 = 0xaaf6b7ff4f12ccd8ULL;
};

template<class ContainerAllocator>
struct DataType< ::stamped_msgs::Char_<ContainerAllocator> >
{
  static const char* value()
  {
    return "stamped_msgs/Char";
  }

  static const char* value(const ::stamped_msgs::Char_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::stamped_msgs::Char_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Header header\n\
char data\n\
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
";
  }

  static const char* value(const ::stamped_msgs::Char_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::stamped_msgs::Char_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.data);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Char_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::stamped_msgs::Char_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::stamped_msgs::Char_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "data: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.data);
  }
};

} // namespace message_operations
} // namespace ros

#endif // STAMPED_MSGS_MESSAGE_CHAR_H
