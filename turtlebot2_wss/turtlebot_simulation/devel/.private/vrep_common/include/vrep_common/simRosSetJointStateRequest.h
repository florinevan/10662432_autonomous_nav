// Generated by gencpp from file vrep_common/simRosSetJointStateRequest.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSSETJOINTSTATEREQUEST_H
#define VREP_COMMON_MESSAGE_SIMROSSETJOINTSTATEREQUEST_H


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
struct simRosSetJointStateRequest_
{
  typedef simRosSetJointStateRequest_<ContainerAllocator> Type;

  simRosSetJointStateRequest_()
    : handles()
    , setModes()
    , values()  {
    }
  simRosSetJointStateRequest_(const ContainerAllocator& _alloc)
    : handles(_alloc)
    , setModes(_alloc)
    , values(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<int32_t, typename ContainerAllocator::template rebind<int32_t>::other >  _handles_type;
  _handles_type handles;

   typedef std::vector<uint8_t, typename ContainerAllocator::template rebind<uint8_t>::other >  _setModes_type;
  _setModes_type setModes;

   typedef std::vector<float, typename ContainerAllocator::template rebind<float>::other >  _values_type;
  _values_type values;





  typedef boost::shared_ptr< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> const> ConstPtr;

}; // struct simRosSetJointStateRequest_

typedef ::vrep_common::simRosSetJointStateRequest_<std::allocator<void> > simRosSetJointStateRequest;

typedef boost::shared_ptr< ::vrep_common::simRosSetJointStateRequest > simRosSetJointStateRequestPtr;
typedef boost::shared_ptr< ::vrep_common::simRosSetJointStateRequest const> simRosSetJointStateRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace vrep_common

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'vrep_common': ['/home/user001/turtlebot2_wss/turtlebot_simulation/src/vrep_common/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "321f1f7210ed1893ea6a335b3eae0c68";
  }

  static const char* value(const ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x321f1f7210ed1893ULL;
  static const uint64_t static_value2 = 0xea6a335b3eae0c68ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosSetJointStateRequest";
  }

  static const char* value(const ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
\n\
\n\
\n\
int32[] handles\n\
uint8[] setModes\n\
float32[] values\n\
";
  }

  static const char* value(const ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.handles);
      stream.next(m.setModes);
      stream.next(m.values);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosSetJointStateRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosSetJointStateRequest_<ContainerAllocator>& v)
  {
    s << indent << "handles[]" << std::endl;
    for (size_t i = 0; i < v.handles.size(); ++i)
    {
      s << indent << "  handles[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.handles[i]);
    }
    s << indent << "setModes[]" << std::endl;
    for (size_t i = 0; i < v.setModes.size(); ++i)
    {
      s << indent << "  setModes[" << i << "]: ";
      Printer<uint8_t>::stream(s, indent + "  ", v.setModes[i]);
    }
    s << indent << "values[]" << std::endl;
    for (size_t i = 0; i < v.values.size(); ++i)
    {
      s << indent << "  values[" << i << "]: ";
      Printer<float>::stream(s, indent + "  ", v.values[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSSETJOINTSTATEREQUEST_H
