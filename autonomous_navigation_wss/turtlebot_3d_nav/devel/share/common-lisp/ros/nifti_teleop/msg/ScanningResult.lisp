; Auto-generated. Do not edit!


(cl:in-package nifti_teleop-msg)


;//! \htmlinclude ScanningResult.msg.html

(cl:defclass <ScanningResult> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass ScanningResult (<ScanningResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ScanningResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ScanningResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nifti_teleop-msg:<ScanningResult> is deprecated: use nifti_teleop-msg:ScanningResult instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <ScanningResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nifti_teleop-msg:result-val is deprecated.  Use nifti_teleop-msg:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ScanningResult>)))
    "Constants for message type '<ScanningResult>"
  '((:SUCCESS . 0)
    (:WARNING . 1)
    (:ERROR . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ScanningResult)))
    "Constants for message type 'ScanningResult"
  '((:SUCCESS . 0)
    (:WARNING . 1)
    (:ERROR . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ScanningResult>) ostream)
  "Serializes a message object of type '<ScanningResult>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ScanningResult>) istream)
  "Deserializes a message object of type '<ScanningResult>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ScanningResult>)))
  "Returns string type for a message object of type '<ScanningResult>"
  "nifti_teleop/ScanningResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ScanningResult)))
  "Returns string type for a message object of type 'ScanningResult"
  "nifti_teleop/ScanningResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ScanningResult>)))
  "Returns md5sum for a message object of type '<ScanningResult>"
  "ee33d82383feeada600abc8b124dd43f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ScanningResult)))
  "Returns md5sum for a message object of type 'ScanningResult"
  "ee33d82383feeada600abc8b124dd43f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ScanningResult>)))
  "Returns full string definition for message of type '<ScanningResult>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%~%byte SUCCESS=0~%byte WARNING=1~%byte ERROR=2~%byte result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ScanningResult)))
  "Returns full string definition for message of type 'ScanningResult"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%~%byte SUCCESS=0~%byte WARNING=1~%byte ERROR=2~%byte result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ScanningResult>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ScanningResult>))
  "Converts a ROS message object to a list"
  (cl:list 'ScanningResult
    (cl:cons ':result (result msg))
))
