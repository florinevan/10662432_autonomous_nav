; Auto-generated. Do not edit!


(cl:in-package stamped_msgs-msg)


;//! \htmlinclude UInt8.msg.html

(cl:defclass <UInt8> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (data
    :reader data
    :initarg :data
    :type cl:fixnum
    :initform 0))
)

(cl:defclass UInt8 (<UInt8>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UInt8>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UInt8)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name stamped_msgs-msg:<UInt8> is deprecated: use stamped_msgs-msg:UInt8 instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UInt8>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader stamped_msgs-msg:header-val is deprecated.  Use stamped_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <UInt8>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader stamped_msgs-msg:data-val is deprecated.  Use stamped_msgs-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UInt8>) ostream)
  "Serializes a message object of type '<UInt8>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'data)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UInt8>) istream)
  "Deserializes a message object of type '<UInt8>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'data)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UInt8>)))
  "Returns string type for a message object of type '<UInt8>"
  "stamped_msgs/UInt8")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UInt8)))
  "Returns string type for a message object of type 'UInt8"
  "stamped_msgs/UInt8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UInt8>)))
  "Returns md5sum for a message object of type '<UInt8>"
  "dd7703d5078812384ba611ee20b8fecf")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UInt8)))
  "Returns md5sum for a message object of type 'UInt8"
  "dd7703d5078812384ba611ee20b8fecf")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UInt8>)))
  "Returns full string definition for message of type '<UInt8>"
  (cl:format cl:nil "Header header~%uint8 data~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UInt8)))
  "Returns full string definition for message of type 'UInt8"
  (cl:format cl:nil "Header header~%uint8 data~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UInt8>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UInt8>))
  "Converts a ROS message object to a list"
  (cl:list 'UInt8
    (cl:cons ':header (header msg))
    (cl:cons ':data (data msg))
))
