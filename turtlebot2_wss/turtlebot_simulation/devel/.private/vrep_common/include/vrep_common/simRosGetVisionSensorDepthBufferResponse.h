// Generated by gencpp from file vrep_common/simRosGetVisionSensorDepthBufferResponse.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSGETVISIONSENSORDEPTHBUFFERRESPONSE_H
#define VREP_COMMON_MESSAGE_SIMROSGETVISIONSENSORDEPTHBUFFERRESPONSE_H


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
struct simRosGetVisionSensorDepthBufferResponse_
{
  typedef simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> Type;

  simRosGetVisionSensorDepthBufferResponse_()
    : result(0)
    , resolution()
    , buffer()  {
    }
  simRosGetVisionSensorDepthBufferResponse_(const ContainerAllocator& _alloc)
    : result(0)
    , resolution(_alloc)
    , buffer(_alloc)  {
  (void)_alloc;
    }



   typedef int32_t _result_type;
  _result_type result;

   typedef std::vector<int32_t, typename ContainerAllocator::template rebind<int32_t>::other >  _resolution_type;
  _resolution_type resolution;

   typedef std::vector<float, typename ContainerAllocator::template rebind<float>::other >  _buffer_type;
  _buffer_type buffer;





  typedef boost::shared_ptr< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> const> ConstPtr;

}; // struct simRosGetVisionSensorDepthBufferResponse_

typedef ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<std::allocator<void> > simRosGetVisionSensorDepthBufferResponse;

typedef boost::shared_ptr< ::vrep_common::simRosGetVisionSensorDepthBufferResponse > simRosGetVisionSensorDepthBufferResponsePtr;
typedef boost::shared_ptr< ::vrep_common::simRosGetVisionSensorDepthBufferResponse const> simRosGetVisionSensorDepthBufferResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace vrep_common

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'vrep_common': ['/home/user001/ROCO506/turtlebot2_wss/turtlebot_simulation/src/vrep_common/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "f3b6a80ea60fe51df97a2b740bd21976";
  }

  static const char* value(const ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xf3b6a80ea60fe51dULL;
  static const uint64_t static_value2 = 0xf97a2b740bd21976ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosGetVisionSensorDepthBufferResponse";
  }

  static const char* value(const ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32 result\n\
int32[] resolution\n\
float32[] buffer\n\
\n\
";
  }

  static const char* value(const ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.result);
      stream.next(m.resolution);
      stream.next(m.buffer);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosGetVisionSensorDepthBufferResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosGetVisionSensorDepthBufferResponse_<ContainerAllocator>& v)
  {
    s << indent << "result: ";
    Printer<int32_t>::stream(s, indent + "  ", v.result);
    s << indent << "resolution[]" << std::endl;
    for (size_t i = 0; i < v.resolution.size(); ++i)
    {
      s << indent << "  resolution[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.resolution[i]);
    }
    s << indent << "buffer[]" << std::endl;
    for (size_t i = 0; i < v.buffer.size(); ++i)
    {
      s << indent << "  buffer[" << i << "]: ";
      Printer<float>::stream(s, indent + "  ", v.buffer[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSGETVISIONSENSORDEPTHBUFFERRESPONSE_H
