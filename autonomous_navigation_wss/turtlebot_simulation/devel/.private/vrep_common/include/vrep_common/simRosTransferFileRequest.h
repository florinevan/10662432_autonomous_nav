// Generated by gencpp from file vrep_common/simRosTransferFileRequest.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_SIMROSTRANSFERFILEREQUEST_H
#define VREP_COMMON_MESSAGE_SIMROSTRANSFERFILEREQUEST_H


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
struct simRosTransferFileRequest_
{
  typedef simRosTransferFileRequest_<ContainerAllocator> Type;

  simRosTransferFileRequest_()
    : data()
    , fileName()  {
    }
  simRosTransferFileRequest_(const ContainerAllocator& _alloc)
    : data(_alloc)
    , fileName(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<uint8_t, typename ContainerAllocator::template rebind<uint8_t>::other >  _data_type;
  _data_type data;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _fileName_type;
  _fileName_type fileName;





  typedef boost::shared_ptr< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> const> ConstPtr;

}; // struct simRosTransferFileRequest_

typedef ::vrep_common::simRosTransferFileRequest_<std::allocator<void> > simRosTransferFileRequest;

typedef boost::shared_ptr< ::vrep_common::simRosTransferFileRequest > simRosTransferFileRequestPtr;
typedef boost::shared_ptr< ::vrep_common::simRosTransferFileRequest const> simRosTransferFileRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c8b761e9b02a5ad1aa85aa2c994c5e52";
  }

  static const char* value(const ::vrep_common::simRosTransferFileRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc8b761e9b02a5ad1ULL;
  static const uint64_t static_value2 = 0xaa85aa2c994c5e52ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/simRosTransferFileRequest";
  }

  static const char* value(const ::vrep_common::simRosTransferFileRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
\n\
\n\
\n\
uint8[] data\n\
string fileName\n\
";
  }

  static const char* value(const ::vrep_common::simRosTransferFileRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.data);
      stream.next(m.fileName);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct simRosTransferFileRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::simRosTransferFileRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::simRosTransferFileRequest_<ContainerAllocator>& v)
  {
    s << indent << "data[]" << std::endl;
    for (size_t i = 0; i < v.data.size(); ++i)
    {
      s << indent << "  data[" << i << "]: ";
      Printer<uint8_t>::stream(s, indent + "  ", v.data[i]);
    }
    s << indent << "fileName: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.fileName);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_SIMROSTRANSFERFILEREQUEST_H
