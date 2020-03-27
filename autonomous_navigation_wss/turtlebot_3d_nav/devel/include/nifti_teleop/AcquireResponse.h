// Generated by gencpp from file nifti_teleop/AcquireResponse.msg
// DO NOT EDIT!


#ifndef NIFTI_TELEOP_MESSAGE_ACQUIRERESPONSE_H
#define NIFTI_TELEOP_MESSAGE_ACQUIRERESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace nifti_teleop
{
template <class ContainerAllocator>
struct AcquireResponse_
{
  typedef AcquireResponse_<ContainerAllocator> Type;

  AcquireResponse_()
    : acquired(false)  {
    }
  AcquireResponse_(const ContainerAllocator& _alloc)
    : acquired(false)  {
  (void)_alloc;
    }



   typedef uint8_t _acquired_type;
  _acquired_type acquired;





  typedef boost::shared_ptr< ::nifti_teleop::AcquireResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::nifti_teleop::AcquireResponse_<ContainerAllocator> const> ConstPtr;

}; // struct AcquireResponse_

typedef ::nifti_teleop::AcquireResponse_<std::allocator<void> > AcquireResponse;

typedef boost::shared_ptr< ::nifti_teleop::AcquireResponse > AcquireResponsePtr;
typedef boost::shared_ptr< ::nifti_teleop::AcquireResponse const> AcquireResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::nifti_teleop::AcquireResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace nifti_teleop

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'nifti_teleop': ['/home/florine_van/10662432_autonomous_nav/autonomous_navigation_wss/turtlebot_3d_nav/devel/share/nifti_teleop/msg'], 'actionlib': ['/opt/ros/kinetic/share/actionlib/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'actionlib_msgs': ['/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::nifti_teleop::AcquireResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::nifti_teleop::AcquireResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::nifti_teleop::AcquireResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "f73f9cb8c9863516d21fc4f714b22191";
  }

  static const char* value(const ::nifti_teleop::AcquireResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xf73f9cb8c9863516ULL;
  static const uint64_t static_value2 = 0xd21fc4f714b22191ULL;
};

template<class ContainerAllocator>
struct DataType< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "nifti_teleop/AcquireResponse";
  }

  static const char* value(const ::nifti_teleop::AcquireResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool acquired\n\
\n\
";
  }

  static const char* value(const ::nifti_teleop::AcquireResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.acquired);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct AcquireResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::nifti_teleop::AcquireResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::nifti_teleop::AcquireResponse_<ContainerAllocator>& v)
  {
    s << indent << "acquired: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.acquired);
  }
};

} // namespace message_operations
} // namespace ros

#endif // NIFTI_TELEOP_MESSAGE_ACQUIRERESPONSE_H
