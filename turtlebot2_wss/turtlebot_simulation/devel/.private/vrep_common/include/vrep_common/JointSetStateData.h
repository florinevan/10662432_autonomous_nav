// Generated by gencpp from file vrep_common/JointSetStateData.msg
// DO NOT EDIT!


#ifndef VREP_COMMON_MESSAGE_JOINTSETSTATEDATA_H
#define VREP_COMMON_MESSAGE_JOINTSETSTATEDATA_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Int32MultiArray.h>
#include <std_msgs/UInt8MultiArray.h>
#include <std_msgs/Float32MultiArray.h>

namespace vrep_common
{
template <class ContainerAllocator>
struct JointSetStateData_
{
  typedef JointSetStateData_<ContainerAllocator> Type;

  JointSetStateData_()
    : handles()
    , setModes()
    , values()  {
    }
  JointSetStateData_(const ContainerAllocator& _alloc)
    : handles(_alloc)
    , setModes(_alloc)
    , values(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Int32MultiArray_<ContainerAllocator>  _handles_type;
  _handles_type handles;

   typedef  ::std_msgs::UInt8MultiArray_<ContainerAllocator>  _setModes_type;
  _setModes_type setModes;

   typedef  ::std_msgs::Float32MultiArray_<ContainerAllocator>  _values_type;
  _values_type values;





  typedef boost::shared_ptr< ::vrep_common::JointSetStateData_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vrep_common::JointSetStateData_<ContainerAllocator> const> ConstPtr;

}; // struct JointSetStateData_

typedef ::vrep_common::JointSetStateData_<std::allocator<void> > JointSetStateData;

typedef boost::shared_ptr< ::vrep_common::JointSetStateData > JointSetStateDataPtr;
typedef boost::shared_ptr< ::vrep_common::JointSetStateData const> JointSetStateDataConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vrep_common::JointSetStateData_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vrep_common::JointSetStateData_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::vrep_common::JointSetStateData_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vrep_common::JointSetStateData_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::JointSetStateData_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vrep_common::JointSetStateData_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::JointSetStateData_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vrep_common::JointSetStateData_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vrep_common::JointSetStateData_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bd1161cd602435f02e226bb73e4acdb9";
  }

  static const char* value(const ::vrep_common::JointSetStateData_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xbd1161cd602435f0ULL;
  static const uint64_t static_value2 = 0x2e226bb73e4acdb9ULL;
};

template<class ContainerAllocator>
struct DataType< ::vrep_common::JointSetStateData_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vrep_common/JointSetStateData";
  }

  static const char* value(const ::vrep_common::JointSetStateData_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vrep_common::JointSetStateData_<ContainerAllocator> >
{
  static const char* value()
  {
    return "std_msgs/Int32MultiArray handles\n\
std_msgs/UInt8MultiArray setModes\n\
std_msgs/Float32MultiArray values\n\
\n\
================================================================================\n\
MSG: std_msgs/Int32MultiArray\n\
# Please look at the MultiArrayLayout message definition for\n\
# documentation on all multiarrays.\n\
\n\
MultiArrayLayout  layout        # specification of data layout\n\
int32[]           data          # array of data\n\
\n\
\n\
================================================================================\n\
MSG: std_msgs/MultiArrayLayout\n\
# The multiarray declares a generic multi-dimensional array of a\n\
# particular data type.  Dimensions are ordered from outer most\n\
# to inner most.\n\
\n\
MultiArrayDimension[] dim # Array of dimension properties\n\
uint32 data_offset        # padding elements at front of data\n\
\n\
# Accessors should ALWAYS be written in terms of dimension stride\n\
# and specified outer-most dimension first.\n\
# \n\
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]\n\
#\n\
# A standard, 3-channel 640x480 image with interleaved color channels\n\
# would be specified as:\n\
#\n\
# dim[0].label  = \"height\"\n\
# dim[0].size   = 480\n\
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)\n\
# dim[1].label  = \"width\"\n\
# dim[1].size   = 640\n\
# dim[1].stride = 3*640 = 1920\n\
# dim[2].label  = \"channel\"\n\
# dim[2].size   = 3\n\
# dim[2].stride = 3\n\
#\n\
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.\n\
\n\
================================================================================\n\
MSG: std_msgs/MultiArrayDimension\n\
string label   # label of given dimension\n\
uint32 size    # size of given dimension (in type units)\n\
uint32 stride  # stride of given dimension\n\
================================================================================\n\
MSG: std_msgs/UInt8MultiArray\n\
# Please look at the MultiArrayLayout message definition for\n\
# documentation on all multiarrays.\n\
\n\
MultiArrayLayout  layout        # specification of data layout\n\
uint8[]           data          # array of data\n\
\n\
\n\
================================================================================\n\
MSG: std_msgs/Float32MultiArray\n\
# Please look at the MultiArrayLayout message definition for\n\
# documentation on all multiarrays.\n\
\n\
MultiArrayLayout  layout        # specification of data layout\n\
float32[]         data          # array of data\n\
\n\
";
  }

  static const char* value(const ::vrep_common::JointSetStateData_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vrep_common::JointSetStateData_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.handles);
      stream.next(m.setModes);
      stream.next(m.values);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct JointSetStateData_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vrep_common::JointSetStateData_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vrep_common::JointSetStateData_<ContainerAllocator>& v)
  {
    s << indent << "handles: ";
    s << std::endl;
    Printer< ::std_msgs::Int32MultiArray_<ContainerAllocator> >::stream(s, indent + "  ", v.handles);
    s << indent << "setModes: ";
    s << std::endl;
    Printer< ::std_msgs::UInt8MultiArray_<ContainerAllocator> >::stream(s, indent + "  ", v.setModes);
    s << indent << "values: ";
    s << std::endl;
    Printer< ::std_msgs::Float32MultiArray_<ContainerAllocator> >::stream(s, indent + "  ", v.values);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VREP_COMMON_MESSAGE_JOINTSETSTATEDATA_H
