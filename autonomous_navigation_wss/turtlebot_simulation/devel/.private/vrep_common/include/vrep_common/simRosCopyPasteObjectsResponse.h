// Generated by gencpp from file vrep_common/simRosCopyPasteObjectsResponse.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSCOPYPASTEOBJECTSRESPONSE_H
#define VREP_COMMON_MESSAGE_SIMROSCOPYPASTEOBJECTSRESPONSE_H


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
struct simRosCopyPasteObjectsResponse_
{
  typedef simRosCopyPasteObjectsResponse_<ContainerAllocator> Type;

  simRosCopyPasteObjectsResponse_()
    : result(0)
    , newObjectHandles()  {
    }
  simRosCopyPasteObjectsResponse_(const ContainerAllocator& _alloc)
    : result(0)
    , newObjectHandles(_alloc)  {
  (void)_alloc;
    }



   typedef int32_t _result_type;
  _result_type result;

   typedef std::vector<int32_t, typename ContainerAllocator::template rebind<int32_t>::other >  _newObjectHandles_type;
  _newObjectHandles_type newObjectHandles;





  typedef boost::shared_ptr< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> const> ConstPtr;

}; // struct simRosCopyPasteObjectsResponse_

typedef ::vrep_common::simRosCopyPasteObjectsResponse_<std::allocator<void> > simRosCopyPasteObjectsResponse;

typedef boost::shared_ptr< ::vrep_common::simRosCopyPasteObjectsResponse > simRosCopyPasteObjectsResponsePtr;
typedef boost::shared_ptr< ::vrep_common::simRosCopyPasteObjectsResponse const> simRosCopyPasteObjectsResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace vrep_common

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'vrep_common': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_simulation/src/vrep_common/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "33b2dafaeb9036bc8402196ac964ff11";
  }

  static const char* value(const ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x33b2dafaeb9036bcULL;
  static const uint64_t static_value2 = 0x8402196ac964ff11ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosCopyPasteObjectsResponse";
  }

  static const char* value(const ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32 result\n\
int32[] newObjectHandles\n\
\n\
";
  }

  static const char* value(const ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.result);
      stream.next(m.newObjectHandles);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosCopyPasteObjectsResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosCopyPasteObjectsResponse_<ContainerAllocator>& v)
  {
    s << indent << "result: ";
    Printer<int32_t>::stream(s, indent + "  ", v.result);
    s << indent << "newObjectHandles[]" << std::endl;
    for (size_t i = 0; i < v.newObjectHandles.size(); ++i)
    {
      s << indent << "  newObjectHandles[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.newObjectHandles[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSCOPYPASTEOBJECTSRESPONSE_H
