
"use strict";

let simRosGetVisionSensorDepthBuffer = require('./simRosGetVisionSensorDepthBuffer.js')
let simRosLoadModel = require('./simRosLoadModel.js')
let simRosGetObjectPose = require('./simRosGetObjectPose.js')
let simRosSetUIButtonProperty = require('./simRosSetUIButtonProperty.js')
let simRosGetUIButtonProperty = require('./simRosGetUIButtonProperty.js')
let simRosLoadUI = require('./simRosLoadUI.js')
let simRosEndDialog = require('./simRosEndDialog.js')
let simRosReadForceSensor = require('./simRosReadForceSensor.js')
let simRosGetDialogInput = require('./simRosGetDialogInput.js')
let simRosTransferFile = require('./simRosTransferFile.js')
let simRosReadVisionSensor = require('./simRosReadVisionSensor.js')
let simRosGetObjectParent = require('./simRosGetObjectParent.js')
let simRosGetObjects = require('./simRosGetObjects.js')
let simRosCallScriptFunction = require('./simRosCallScriptFunction.js')
let simRosSetUISlider = require('./simRosSetUISlider.js')
let simRosAuxiliaryConsolePrint = require('./simRosAuxiliaryConsolePrint.js')
let simRosAuxiliaryConsoleClose = require('./simRosAuxiliaryConsoleClose.js')
let simRosClearStringSignal = require('./simRosClearStringSignal.js')
let simRosSetIntegerSignal = require('./simRosSetIntegerSignal.js')
let simRosAuxiliaryConsoleShow = require('./simRosAuxiliaryConsoleShow.js')
let simRosGetStringSignal = require('./simRosGetStringSignal.js')
let simRosSetJointTargetVelocity = require('./simRosSetJointTargetVelocity.js')
let simRosRemoveModel = require('./simRosRemoveModel.js')
let simRosSetJointTargetPosition = require('./simRosSetJointTargetPosition.js')
let simRosStopSimulation = require('./simRosStopSimulation.js')
let simRosPauseSimulation = require('./simRosPauseSimulation.js')
let simRosSetJointState = require('./simRosSetJointState.js')
let simRosGetCollectionHandle = require('./simRosGetCollectionHandle.js')
let simRosGetUIEventButton = require('./simRosGetUIEventButton.js')
let simRosSetJointPosition = require('./simRosSetJointPosition.js')
let simRosSetBooleanParameter = require('./simRosSetBooleanParameter.js')
let simRosCloseScene = require('./simRosCloseScene.js')
let simRosSetUIButtonLabel = require('./simRosSetUIButtonLabel.js')
let simRosRemoveObject = require('./simRosRemoveObject.js')
let simRosSetStringSignal = require('./simRosSetStringSignal.js')
let simRosSetFloatSignal = require('./simRosSetFloatSignal.js')
let simRosBreakForceSensor = require('./simRosBreakForceSensor.js')
let simRosSetObjectIntParameter = require('./simRosSetObjectIntParameter.js')
let simRosGetAndClearStringSignal = require('./simRosGetAndClearStringSignal.js')
let simRosClearIntegerSignal = require('./simRosClearIntegerSignal.js')
let simRosGetModelProperty = require('./simRosGetModelProperty.js')
let simRosGetJointMatrix = require('./simRosGetJointMatrix.js')
let simRosAuxiliaryConsoleOpen = require('./simRosAuxiliaryConsoleOpen.js')
let simRosSetSphericalJointMatrix = require('./simRosSetSphericalJointMatrix.js')
let simRosSynchronous = require('./simRosSynchronous.js')
let simRosEnableSubscriber = require('./simRosEnableSubscriber.js')
let simRosGetIntegerParameter = require('./simRosGetIntegerParameter.js')
let simRosSetObjectQuaternion = require('./simRosSetObjectQuaternion.js')
let simRosGetArrayParameter = require('./simRosGetArrayParameter.js')
let simRosClearFloatSignal = require('./simRosClearFloatSignal.js')
let simRosGetStringParameter = require('./simRosGetStringParameter.js')
let simRosGetJointState = require('./simRosGetJointState.js')
let simRosGetObjectHandle = require('./simRosGetObjectHandle.js')
let simRosSetJointForce = require('./simRosSetJointForce.js')
let simRosDisablePublisher = require('./simRosDisablePublisher.js')
let simRosAppendStringSignal = require('./simRosAppendStringSignal.js')
let simRosSetObjectPose = require('./simRosSetObjectPose.js')
let simRosSetIntegerParameter = require('./simRosSetIntegerParameter.js')
let simRosDisableSubscriber = require('./simRosDisableSubscriber.js')
let simRosGetVisionSensorImage = require('./simRosGetVisionSensorImage.js')
let simRosGetUISlider = require('./simRosGetUISlider.js')
let simRosDisplayDialog = require('./simRosDisplayDialog.js')
let simRosRemoveUI = require('./simRosRemoveUI.js')
let simRosGetUIHandle = require('./simRosGetUIHandle.js')
let simRosSetFloatingParameter = require('./simRosSetFloatingParameter.js')
let simRosAddStatusbarMessage = require('./simRosAddStatusbarMessage.js')
let simRosStartSimulation = require('./simRosStartSimulation.js')
let simRosEnablePublisher = require('./simRosEnablePublisher.js')
let simRosSynchronousTrigger = require('./simRosSynchronousTrigger.js')
let simRosSetModelProperty = require('./simRosSetModelProperty.js')
let simRosSetObjectParent = require('./simRosSetObjectParent.js')
let simRosCopyPasteObjects = require('./simRosCopyPasteObjects.js')
let simRosGetFloatingParameter = require('./simRosGetFloatingParameter.js')
let simRosEraseFile = require('./simRosEraseFile.js')
let simRosSetObjectFloatParameter = require('./simRosSetObjectFloatParameter.js')
let simRosSetObjectSelection = require('./simRosSetObjectSelection.js')
let simRosGetObjectIntParameter = require('./simRosGetObjectIntParameter.js')
let simRosGetBooleanParameter = require('./simRosGetBooleanParameter.js')
let simRosSetObjectPosition = require('./simRosSetObjectPosition.js')
let simRosGetObjectGroupData = require('./simRosGetObjectGroupData.js')
let simRosGetDialogResult = require('./simRosGetDialogResult.js')
let simRosReadProximitySensor = require('./simRosReadProximitySensor.js')
let simRosSetArrayParameter = require('./simRosSetArrayParameter.js')
let simRosGetFloatSignal = require('./simRosGetFloatSignal.js')
let simRosGetObjectSelection = require('./simRosGetObjectSelection.js')
let simRosGetObjectChild = require('./simRosGetObjectChild.js')
let simRosGetObjectFloatParameter = require('./simRosGetObjectFloatParameter.js')
let simRosGetInfo = require('./simRosGetInfo.js')
let simRosCreateDummy = require('./simRosCreateDummy.js')
let simRosSetVisionSensorImage = require('./simRosSetVisionSensorImage.js')
let simRosReadDistance = require('./simRosReadDistance.js')
let simRosReadCollision = require('./simRosReadCollision.js')
let simRosGetIntegerSignal = require('./simRosGetIntegerSignal.js')
let simRosGetCollisionHandle = require('./simRosGetCollisionHandle.js')
let simRosGetDistanceHandle = require('./simRosGetDistanceHandle.js')
let simRosLoadScene = require('./simRosLoadScene.js')
let simRosGetLastErrors = require('./simRosGetLastErrors.js')

module.exports = {
  simRosGetVisionSensorDepthBuffer: simRosGetVisionSensorDepthBuffer,
  simRosLoadModel: simRosLoadModel,
  simRosGetObjectPose: simRosGetObjectPose,
  simRosSetUIButtonProperty: simRosSetUIButtonProperty,
  simRosGetUIButtonProperty: simRosGetUIButtonProperty,
  simRosLoadUI: simRosLoadUI,
  simRosEndDialog: simRosEndDialog,
  simRosReadForceSensor: simRosReadForceSensor,
  simRosGetDialogInput: simRosGetDialogInput,
  simRosTransferFile: simRosTransferFile,
  simRosReadVisionSensor: simRosReadVisionSensor,
  simRosGetObjectParent: simRosGetObjectParent,
  simRosGetObjects: simRosGetObjects,
  simRosCallScriptFunction: simRosCallScriptFunction,
  simRosSetUISlider: simRosSetUISlider,
  simRosAuxiliaryConsolePrint: simRosAuxiliaryConsolePrint,
  simRosAuxiliaryConsoleClose: simRosAuxiliaryConsoleClose,
  simRosClearStringSignal: simRosClearStringSignal,
  simRosSetIntegerSignal: simRosSetIntegerSignal,
  simRosAuxiliaryConsoleShow: simRosAuxiliaryConsoleShow,
  simRosGetStringSignal: simRosGetStringSignal,
  simRosSetJointTargetVelocity: simRosSetJointTargetVelocity,
  simRosRemoveModel: simRosRemoveModel,
  simRosSetJointTargetPosition: simRosSetJointTargetPosition,
  simRosStopSimulation: simRosStopSimulation,
  simRosPauseSimulation: simRosPauseSimulation,
  simRosSetJointState: simRosSetJointState,
  simRosGetCollectionHandle: simRosGetCollectionHandle,
  simRosGetUIEventButton: simRosGetUIEventButton,
  simRosSetJointPosition: simRosSetJointPosition,
  simRosSetBooleanParameter: simRosSetBooleanParameter,
  simRosCloseScene: simRosCloseScene,
  simRosSetUIButtonLabel: simRosSetUIButtonLabel,
  simRosRemoveObject: simRosRemoveObject,
  simRosSetStringSignal: simRosSetStringSignal,
  simRosSetFloatSignal: simRosSetFloatSignal,
  simRosBreakForceSensor: simRosBreakForceSensor,
  simRosSetObjectIntParameter: simRosSetObjectIntParameter,
  simRosGetAndClearStringSignal: simRosGetAndClearStringSignal,
  simRosClearIntegerSignal: simRosClearIntegerSignal,
  simRosGetModelProperty: simRosGetModelProperty,
  simRosGetJointMatrix: simRosGetJointMatrix,
  simRosAuxiliaryConsoleOpen: simRosAuxiliaryConsoleOpen,
  simRosSetSphericalJointMatrix: simRosSetSphericalJointMatrix,
  simRosSynchronous: simRosSynchronous,
  simRosEnableSubscriber: simRosEnableSubscriber,
  simRosGetIntegerParameter: simRosGetIntegerParameter,
  simRosSetObjectQuaternion: simRosSetObjectQuaternion,
  simRosGetArrayParameter: simRosGetArrayParameter,
  simRosClearFloatSignal: simRosClearFloatSignal,
  simRosGetStringParameter: simRosGetStringParameter,
  simRosGetJointState: simRosGetJointState,
  simRosGetObjectHandle: simRosGetObjectHandle,
  simRosSetJointForce: simRosSetJointForce,
  simRosDisablePublisher: simRosDisablePublisher,
  simRosAppendStringSignal: simRosAppendStringSignal,
  simRosSetObjectPose: simRosSetObjectPose,
  simRosSetIntegerParameter: simRosSetIntegerParameter,
  simRosDisableSubscriber: simRosDisableSubscriber,
  simRosGetVisionSensorImage: simRosGetVisionSensorImage,
  simRosGetUISlider: simRosGetUISlider,
  simRosDisplayDialog: simRosDisplayDialog,
  simRosRemoveUI: simRosRemoveUI,
  simRosGetUIHandle: simRosGetUIHandle,
  simRosSetFloatingParameter: simRosSetFloatingParameter,
  simRosAddStatusbarMessage: simRosAddStatusbarMessage,
  simRosStartSimulation: simRosStartSimulation,
  simRosEnablePublisher: simRosEnablePublisher,
  simRosSynchronousTrigger: simRosSynchronousTrigger,
  simRosSetModelProperty: simRosSetModelProperty,
  simRosSetObjectParent: simRosSetObjectParent,
  simRosCopyPasteObjects: simRosCopyPasteObjects,
  simRosGetFloatingParameter: simRosGetFloatingParameter,
  simRosEraseFile: simRosEraseFile,
  simRosSetObjectFloatParameter: simRosSetObjectFloatParameter,
  simRosSetObjectSelection: simRosSetObjectSelection,
  simRosGetObjectIntParameter: simRosGetObjectIntParameter,
  simRosGetBooleanParameter: simRosGetBooleanParameter,
  simRosSetObjectPosition: simRosSetObjectPosition,
  simRosGetObjectGroupData: simRosGetObjectGroupData,
  simRosGetDialogResult: simRosGetDialogResult,
  simRosReadProximitySensor: simRosReadProximitySensor,
  simRosSetArrayParameter: simRosSetArrayParameter,
  simRosGetFloatSignal: simRosGetFloatSignal,
  simRosGetObjectSelection: simRosGetObjectSelection,
  simRosGetObjectChild: simRosGetObjectChild,
  simRosGetObjectFloatParameter: simRosGetObjectFloatParameter,
  simRosGetInfo: simRosGetInfo,
  simRosCreateDummy: simRosCreateDummy,
  simRosSetVisionSensorImage: simRosSetVisionSensorImage,
  simRosReadDistance: simRosReadDistance,
  simRosReadCollision: simRosReadCollision,
  simRosGetIntegerSignal: simRosGetIntegerSignal,
  simRosGetCollisionHandle: simRosGetCollisionHandle,
  simRosGetDistanceHandle: simRosGetDistanceHandle,
  simRosLoadScene: simRosLoadScene,
  simRosGetLastErrors: simRosGetLastErrors,
};
