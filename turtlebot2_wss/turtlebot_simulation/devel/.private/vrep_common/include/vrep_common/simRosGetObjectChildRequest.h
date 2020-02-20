// Generated by gencpp from file vrep_common/simRosGetObjectChildRequest.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSGETOBJECTCHILDREQUEST_H
#define VREP_COMMON_MESSAGE_SIMROSGETOBJECTCHILDREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace vrep_common
{
template <class ContainerAllocator>
struct simRosGetObjectChildRequest_
{
  typedef simRosGetObjectChildRequest_<ContainerAllocator> Type;

  simRosGetObjectChildRequest_()
    : handle(0)
    , index(0)  {
    }
  simRosGetObjectChildRequest_(const ContainerAllocator& _alloc)
    : handle(0)
    , index(0)  {
  (void)_alloc;
    }



   typedef int32_t _handle_type;
  _handle_type handle;

   typedef int32_t _index_type;
  _index_type index;





  typedef boost::shared_ptr< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> const> ConstPtr;

}; // struct simRosGetObjectChildRequest_

typedef ::vrep_common::simRosGetObjectChildRequest_<std::allocator<void> > simRosGetObjectChildRequest;

typedef boost::shared_ptr< ::vrep_common::simRosGetObjectChildRequest > simRosGetObjectChildRequestPtr;
typedef boost::shared_ptr< ::vrep_common::simRosGetObjectChildRequest const> simRosGetObjectChildRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace vrep_common

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'vrep_common': ['/home/user001/ROCO506/turtlebot2_wss/turtlebot_simulation/src/vrep_common/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "38a6074f4ac9f6ddcbf3ed839a2974d2";
  }

  static const char* value(const ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x38a6074f4ac9f6ddULL;
  static const uint64_t static_value2 = 0xcbf3ed839a2974d2ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosGetObjectChildRequest";
  }

  static const char* value(const ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
\n\
\n\
\n\
int32 handle\n\
int32 index\n\
";
  }

  static const char* value(const ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.handle);
      stream.next(m.index);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosGetObjectChildRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosGetObjectChildRequest_<ContainerAllocator>& v)
  {
    s << indent << "handle: ";
    Printer<int32_t>::stream(s, indent + "  ", v.handle);
    s << indent << "index: ";
    Printer<int32_t>::stream(s, indent + "  ", v.index);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSGETOBJECTCHILDREQUEST_H
