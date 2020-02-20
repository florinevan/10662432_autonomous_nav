// Generated by gencpp from file vrep_common/simRosSetJointTargetVelocityRequest.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSSETJOINTTARGETVELOCITYREQUEST_H
#define VREP_COMMON_MESSAGE_SIMROSSETJOINTTARGETVELOCITYREQUEST_H


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
struct simRosSetJointTargetVelocityRequest_
{
  typedef simRosSetJointTargetVelocityRequest_<ContainerAllocator> Type;

  simRosSetJointTargetVelocityRequest_()
    : handle(0)
    , targetVelocity(0.0)  {
    }
  simRosSetJointTargetVelocityRequest_(const ContainerAllocator& _alloc)
    : handle(0)
    , targetVelocity(0.0)  {
  (void)_alloc;
    }



   typedef int32_t _handle_type;
  _handle_type handle;

   typedef double _targetVelocity_type;
  _targetVelocity_type targetVelocity;





  typedef boost::shared_ptr< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> const> ConstPtr;

}; // struct simRosSetJointTargetVelocityRequest_

typedef ::vrep_common::simRosSetJointTargetVelocityRequest_<std::allocator<void> > simRosSetJointTargetVelocityRequest;

typedef boost::shared_ptr< ::vrep_common::simRosSetJointTargetVelocityRequest > simRosSetJointTargetVelocityRequestPtr;
typedef boost::shared_ptr< ::vrep_common::simRosSetJointTargetVelocityRequest const> simRosSetJointTargetVelocityRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a3f4b46893a91525225ffda04544130e";
  }

  static const char* value(const ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa3f4b46893a91525ULL;
  static const uint64_t static_value2 = 0x225ffda04544130eULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosSetJointTargetVelocityRequest";
  }

  static const char* value(const ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
\n\
\n\
\n\
int32 handle\n\
float64 targetVelocity\n\
";
  }

  static const char* value(const ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.handle);
      stream.next(m.targetVelocity);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosSetJointTargetVelocityRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosSetJointTargetVelocityRequest_<ContainerAllocator>& v)
  {
    s << indent << "handle: ";
    Printer<int32_t>::stream(s, indent + "  ", v.handle);
    s << indent << "targetVelocity: ";
    Printer<double>::stream(s, indent + "  ", v.targetVelocity);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSSETJOINTTARGETVELOCITYREQUEST_H
