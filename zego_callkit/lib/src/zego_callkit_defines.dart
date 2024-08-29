import 'internal/utils/uuid_impl.dart';

enum CXHandleType {
  CXHandleTypeGeneric,
  CXHandleTypePhoneNumber,
  CXHandleTypeEmailAddress
}

enum CXCallEndedReason {

  /// An error occurred while trying to service the call
  CXCallEndedReasonFailed,

  /// The remote party explicitly ended the call
  CXCallEndedReasonRemoteEnded,

  /// The call never started connecting and was never explicitly ended (e.g. outgoing/incoming call timeout)
  CXCallEndedReasonUnanswered,

  /// The call was answered on another device
  CXCallEndedReasonAnsweredElsewhere,

  /// The call was declined on another device
  CXCallEndedReasonDeclinedElsewhere
}

enum CXPlayDTMFCallActionType{
  CXPlayDTMFCallActionTypeSingleTone,
  CXPlayDTMFCallActionTypeSoftPause,
  CXPlayDTMFCallActionTypeHardPause
}


class CXProviderConfiguration {

  /// Localized name of the provider
  String localizedName;

  /// Default NO
  bool? supportsVideo_;

  /// Default 5
  int? maximumCallsPerCallGroup_;

  /// Default 2
  int? maximumCallGroups_;

  /// Numbers are of type CXHandleType
  List<CXHandleType>? supportedHandleTypes_;

  /// Image should be a square with side length of 40 points
  String? iconTemplateImageName_;



  CXProviderConfiguration({required this.localizedName,bool? supportsVideo,int? maximumCallsPerCallGroup,int? maximumCallGroups,List<CXHandleType>? supportedHandleTypes, String? iconTemplateImageName}){
    supportsVideo_ = supportsVideo;
    maximumCallsPerCallGroup_ = maximumCallsPerCallGroup;
    maximumCallGroups_ = maximumCallGroups;
    supportedHandleTypes_ = supportedHandleTypes;
    iconTemplateImageName_ = iconTemplateImageName;
  }
}

class CXCallUpdate {
  /// Handle for the remote party (for an incoming call, the caller; for an outgoing call, the callee).
  CXHandle? remoteHandle;

  /// Override the computed caller name to a provider-defined value.
  /// Normally the system will determine the appropriate caller name to display (e.g. using the user's contacts) based on the supplied caller identifier. Set this property to customize.
  String? localizedCallerName;

  /// Whether the call can be held on its own or swapped with another call
  bool? supportsHolding;

  /// Whether the call can be grouped (merged) with other calls when it is ungrouped
  bool? supportsGrouping;

  /// The call can be ungrouped (taken private) when it is grouped
  bool? supportsUngrouping;

  /// The call can send DTMF tones via hard pause digits or in-call keypad entries
  bool? supportsDTMF;

  /// The call includes video in addition to audio.
  bool? hasVideo;

  CXCallUpdate({CXHandle? remoteHandle_,String? localizedCallerName_, bool? supportsHolding_, bool? supportsGrouping_, bool?supportsUngrouping_, bool?supportsDTMF_,bool? hasVideo_}){

    remoteHandle = remoteHandle_;
    localizedCallerName = localizedCallerName_;
    supportsHolding = supportsHolding_;
    supportsGrouping = supportsGrouping_;
    supportsUngrouping = supportsUngrouping_;
    supportsDTMF = supportsDTMF_;
    hasVideo = hasVideo_;
  }
}


class CXHandle{
  CXHandleType type;
  String value;
  CXHandle({required this.type,required this.value});
}

abstract class CXAction{
  fulfill();
  fail();
}

abstract class CXCallAction extends CXAction{
  late UUID callUUID;
}

abstract class CXStartCallAction extends CXCallAction{
  late CXHandle handle;
  late String contactIdentifier;
  late bool video;
}

abstract class CXAnswerCallAction extends CXCallAction{}

abstract class CXEndCallAction extends CXCallAction{}

abstract class CXSetHeldCallAction extends CXCallAction{
  late bool onHold;
}

abstract class CXSetMutedCallAction extends CXCallAction{
  late bool muted;
}

abstract class CXSetGroupCallAction extends CXCallAction{}

abstract class CXPlayDTMFCallAction extends CXCallAction{
  late String digits;
  late CXPlayDTMFCallActionType type;
}


abstract class UUID {
  /// Create a new autoreleased NSUUID with RFC 4122 version 4 random bytes.
  static UUID getUUID(){
    return UUIDImpl.getUUID();
  }
}

