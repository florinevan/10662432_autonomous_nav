#include <string>
#include <stdio.h>
#include <ros/ros.h>

#include <geometry_msgs/Twist.h>
#include <nifti_robot_driver_msgs/TracksStamped.h>


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

class NavigationStack
{
private:
	ros::NodeHandle n_;
 	
protected: 
	ros::NodeHandle node;
    	std::string cmd_vel_topic_name;
	std::string wheels_cmd_pub_name;
	double max_wheel_vel;
	double robot_width;

public:
	NavigationStack();
	~NavigationStack();
	ros::Subscriber cmd_vel_sub;
	ros::Publisher wheels_cmd_pub;
	void nav_stack_callback(const geometry_msgs::Twist& cmd_vel_msg);
};

NavigationStack::NavigationStack(): n_("~"){
	cmd_vel_topic_name = getParam<std::string>(n_, "cmd_vel_topic_name", "/cmd_vel");
	wheels_cmd_pub_name = getParam<std::string>(n_, "wheels_cmd_topic_name", "/turtlebot1/wheels_vel_cmd");
	cmd_vel_sub = node.subscribe(cmd_vel_topic_name, 1, &NavigationStack::nav_stack_callback, this);
	wheels_cmd_pub = node.advertise<nifti_robot_driver_msgs::TracksStamped>(wheels_cmd_pub_name, 1000);

        max_wheel_vel = getParam<double>(n_, "max_wheel_vel", 0.65);
   	robot_width = getParam<double>(n_, "robot_width", 0.354);
}

NavigationStack::~NavigationStack() {}


void NavigationStack::nav_stack_callback(const geometry_msgs::Twist& cmd_vel_msg)
{
	double linear_vel = cmd_vel_msg.linear.x;
	double angular_vel = cmd_vel_msg.angular.z;

	double d = robot_width/2;

        nifti_robot_driver_msgs::TracksStamped wheels_cmd_msg;

	wheels_cmd_msg.left = linear_vel - (d * angular_vel);
	wheels_cmd_msg.right = linear_vel + (d * angular_vel);

	if(wheels_cmd_msg.left < -max_wheel_vel)
	{
		wheels_cmd_msg.left = -max_wheel_vel;
	}
	if(wheels_cmd_msg.left > max_wheel_vel)
	{
		wheels_cmd_msg.left = max_wheel_vel;
	}
	if(wheels_cmd_msg.right < -max_wheel_vel)
	{
		wheels_cmd_msg.right = -max_wheel_vel;
	}
	if(wheels_cmd_msg.right > max_wheel_vel)
	{
		wheels_cmd_msg.right = max_wheel_vel;
	}

	wheels_cmd_pub.publish(wheels_cmd_msg);
}


int main(int argc, char* argv[]) {

	ros::init(argc, argv, "navigation_stack");

	NavigationStack nav_stack;

	ros::spin();

	return 0;
}
