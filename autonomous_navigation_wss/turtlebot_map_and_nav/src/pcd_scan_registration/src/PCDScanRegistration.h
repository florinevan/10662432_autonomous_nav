#ifndef PCDScanRegistration_H
#define PCDScanRegistration_H

class PCDScanRegistration{
    
private:
    ros::NodeHandle n_;
    
protected:
    ros::NodeHandle node;
    sensor_msgs::PointCloud2 pcd_msg;
    string 
    string pcd_colored_topic_name;
       
public:
    TwisttoDifferentialDrive();
    ~TwisttoDifferentialDrive();
    ros::Subscriber ;
    ros::Publisher pcd_colored_sub;
    void dynamicCloudCallback(const sensor_msgs::PointCloud2ConstPtr&);
};

#endif /* TwisttoDifferentialDrive_H */
