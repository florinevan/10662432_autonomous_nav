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

public:
	NavigationStack();
	~NavigationStack();
	ros:Subscriber cmd_vel_sub;
	ros:Publisher wheels_cmd_pub;
	void nav_stack_callback(const geometry_msgs::Twist& cmd_vel_msg);
}

NavigationStack::NavigationStack(): n_("~") {
	cmd_vel_topic_name = getParam<std::string>(n_, "cmd_vel_topic_name", "/cmd_vel");
	wheels_cmd_pub_name = getParam<std::string>(n_, "wheels_cmd_topic_name", "/turtlebot1/wheels_vel_cmd");
	cmd_vel_sub = node.subscribe(cmd_vel_topic_name, 1, &NavigationStack::nav_stack_callback, this);
	wheels_cmd_pub = node.advertise<geometry_msgs::Twist>(wheels_cmd_pub_name, 1000);
}

NavigationStack::~NavigationStack() {}


void NavigationStack::nav_stack_callback(const geometry_msgs::Twist& cmd_vel_msg)
{
	double linear_vel = cmd_vel_msg.linear.x;
	double angular_vel = cmd_vel_msgs.angular.z;

	double d = robot_width/2;

	tracks_cmd.left = linear_vel - (d * angular_vel);
	tracks_cmd.right = linear_vel + (d * angular_vel);

	if(wheels_cmd.left < -max_wheel_vel)
	{
		wheels_cmd.left = -max_wheel_vel;
	}
	if(wheels_cmd.left > max_wheel_vel)
	{
		wheels_cmd.left = max_wheel_vel;
	}
	if(wheels_cmd.right < -max_wheel_vel)
	{
		wheels_cmd.right = -max_wheel_vel;
	}
	if(wheels_cmd.right > max_wheel_vel)
	{
		wheels_cmd.right = max_wheel_vel;
	}

	wheels_cmd_pub.publish(wheels_cmd);
}


int main(int argc, char* argv[]) {

	ros::init(argc, argv, "navigation_stack");

	NavigationStack nav_stack;

	ros::spin();

	return 0;
}
