// Generated by gencpp from file vrep_common/simRosAuxiliaryConsoleCloseRequest.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSAUXILIARYCONSOLECLOSEREQUEST_H
#define VREP_COMMON_MESSAGE_SIMROSAUXILIARYCONSOLECLOSEREQUEST_H


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
struct simRosAuxiliaryConsoleCloseRequest_
{
  typedef simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> Type;

  simRosAuxiliaryConsoleCloseRequest_()
    : consoleHandle(0)  {
    }
  simRosAuxiliaryConsoleCloseRequest_(const ContainerAllocator& _alloc)
    : consoleHandle(0)  {
  (void)_alloc;
    }



   typedef int32_t _consoleHandle_type;
  _consoleHandle_type consoleHandle;





  typedef boost::shared_ptr< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> const> ConstPtr;

}; // struct simRosAuxiliaryConsoleCloseRequest_

typedef ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<std::allocator<void> > simRosAuxiliaryConsoleCloseRequest;

typedef boost::shared_ptr< ::vrep_common::simRosAuxiliaryConsoleCloseRequest > simRosAuxiliaryConsoleCloseRequestPtr;
typedef boost::shared_ptr< ::vrep_common::simRosAuxiliaryConsoleCloseRequest const> simRosAuxiliaryConsoleCloseRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace vrep_common

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'vrep_common': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_simulation/src/vrep_common/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "0712f8f971970cd49793e7755140f018";
  }

  static const char* value(const ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x0712f8f971970cd4ULL;
  static const uint64_t static_value2 = 0x9793e7755140f018ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosAuxiliaryConsoleCloseRequest";
  }

  static const char* value(const ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
\n\
\n\
\n\
int32 consoleHandle\n\
";
  }

  static const char* value(const ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.consoleHandle);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosAuxiliaryConsoleCloseRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosAuxiliaryConsoleCloseRequest_<ContainerAllocator>& v)
  {
    s << indent << "consoleHandle: ";
    Printer<int32_t>::stream(s, indent + "  ", v.consoleHandle);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSAUXILIARYCONSOLECLOSEREQUEST_H
