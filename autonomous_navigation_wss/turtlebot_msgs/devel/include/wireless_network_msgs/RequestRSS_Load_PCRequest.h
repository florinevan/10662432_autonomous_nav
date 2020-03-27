// Generated by gencpp from file wireless_network_msgs/RequestRSS_Load_PCRequest.msg
// DO NOT EDIT!


#ifndef WIRELESS_NETWORK_MSGS_MESSAGE_REQUESTRSS_LOAD_PCREQUEST_H
#define WIRELESS_NETWORK_MSGS_MESSAGE_REQUESTRSS_LOAD_PCREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace wireless_network_msgs
{
template <class ContainerAllocator>
struct RequestRSS_Load_PCRequest_
{
  typedef RequestRSS_Load_PCRequest_<ContainerAllocator> Type;

  RequestRSS_Load_PCRequest_()
    {
    }
  RequestRSS_Load_PCRequest_(const ContainerAllocator& _alloc)
    {
  (void)_alloc;
    }







  typedef boost::shared_ptr< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> const> ConstPtr;

}; // struct RequestRSS_Load_PCRequest_

typedef ::wireless_network_msgs::RequestRSS_Load_PCRequest_<std::allocator<void> > RequestRSS_Load_PCRequest;

typedef boost::shared_ptr< ::wireless_network_msgs::RequestRSS_Load_PCRequest > RequestRSS_Load_PCRequestPtr;
typedef boost::shared_ptr< ::wireless_network_msgs::RequestRSS_Load_PCRequest const> RequestRSS_Load_PCRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace wireless_network_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'wireless_network_msgs': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_msgs/src/wireless_network_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "d41d8cd98f00b204e9800998ecf8427e";
  }

  static const char* value(const ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xd41d8cd98f00b204ULL;
  static const uint64_t static_value2 = 0xe9800998ecf8427eULL;
};

template<class ContainerAllocator>
struct DataType< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "wireless_network_msgs/RequestRSS_Load_PCRequest";
  }

  static const char* value(const ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
";
  }

  static const char* value(const ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream&, T)
    {}

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct RequestRSS_Load_PCRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream&, const std::string&, const ::wireless_network_msgs::RequestRSS_Load_PCRequest_<ContainerAllocator>&)
  {}
};

} // namespace message_operations
} // namespace ros

#endif // WIRELESS_NETWORK_MSGS_MESSAGE_REQUESTRSS_LOAD_PCREQUEST_H
