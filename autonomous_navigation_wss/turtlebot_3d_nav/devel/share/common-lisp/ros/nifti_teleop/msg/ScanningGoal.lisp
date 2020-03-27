; Auto-generated. Do not edit!


(cl:in-package nifti_teleop-msg)


;//! \htmlinclude ScanningGoal.msg.html

(cl:defclass <ScanningGoal> (roslisp-msg-protocol:ros-message)
  ((action
    :reader action
    :initarg :action
    :type cl:integer
    :initform 0)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0))
)

(cl:defclass ScanningGoal (<ScanningGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ScanningGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ScanningGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nifti_teleop-msg:<ScanningGoal> is deprecated: use nifti_teleop-msg:ScanningGoal instead.")))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <ScanningGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nifti_teleop-msg:action-val is deprecated.  Use nifti_teleop-msg:action instead.")
  (action m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <ScanningGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nifti_teleop-msg:speed-val is deprecated.  Use nifti_teleop-msg:speed instead.")
  (speed m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ScanningGoal>)))
    "Constants for message type '<ScanningGoal>"
  '((:START_SCANNING . 0)
    (:STOP_SCANNING . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ScanningGoal)))
    "Constants for message type 'ScanningGoal"
  '((:START_SCANNING . 0)
    (:STOP_SCANNING . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ScanningGoal>) ostream)
  "Serializes a message object of type '<ScanningGoal>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ScanningGoal>) istream)
  "Deserializes a message object of type '<ScanningGoal>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ScanningGoal>)))
  "Returns string type for a message object of type '<ScanningGoal>"
  "nifti_teleop/ScanningGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ScanningGoal)))
  "Returns string type for a message object of type 'ScanningGoal"
  "nifti_teleop/ScanningGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ScanningGoal>)))
  "Returns md5sum for a message object of type '<ScanningGoal>"
  "e0e7f34c8ef5653cd02b0d698e9cea8c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ScanningGoal)))
  "Returns md5sum for a message object of type 'ScanningGoal"
  "e0e7f34c8ef5653cd02b0d698e9cea8c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ScanningGoal>)))
  "Returns full string definition for message of type '<ScanningGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%byte START_SCANNING=0~%byte STOP_SCANNING=1~%byte action~%float64 speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ScanningGoal)))
  "Returns full string definition for message of type 'ScanningGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%byte START_SCANNING=0~%byte STOP_SCANNING=1~%byte action~%float64 speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ScanningGoal>))
  (cl:+ 0
     1
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ScanningGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'ScanningGoal
    (cl:cons ':action (action msg))
    (cl:cons ':speed (speed msg))
))
