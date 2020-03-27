
#include <string>
#include <stdio.h>
#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>

#include <PCDScanRegistration.h>

template<typename T>
T getParam(ros::NodeHandle& n, const std::string& name, const T& defaultValue)
{
	T v;
	if (n.getParam(name, v))
	{
		ROS_INFO_STREAM("Found parameter: " << name << ", value: " << v);
		return v;
	}
	else
        {
		ROS_WARN_STREAM("Cannot find value for parameter: " << name << ", assigning default: " << defaultValue);
        }
	return defaultValue;
}

PCDScanRegistration::PCDScanRegistration():
        n_("~")
{
	 = getParam<std::string>(n_, "", "");
	 = node.subscribe(_name,1,&PCDScanRegistration::twist_callback,this);
	pcd_colored_topic_name = getParam<std::string>(n_, "pcd_colored_topic_name", "pcd_colored_topic_name");
	pcd_colored_sub = node.advertise<sensor_msgs::PointCloud2>(pcd_colored_topic_name,1);
}

PCDScanRegistration::~TwisttoDifferentialDrive(){}


void PCDScanRegistration::dynamicCloudCallback(const sensor_msgs::PointCloud2ConstPtr& msg)
{
	pcd_msg = msg;
	pcd_colored_sub.publish(pcd_msg);
}

int main(int argc, char* argv[]){
    
    ros::init (argc, argv, "pcd_scan_registration");
    PCDScanRegistration pcd_scan_reg;
    ros::spin();
    return 0;
}

