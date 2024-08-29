import '../zego_callkit_defines.dart';
import 'callkit_internal_defines.dart';

extension CXHandleTypeExtension on CXHandleType {
  static const valueMap = {
    CXHandleType.CXHandleTypeGeneric: 1,
    CXHandleType.CXHandleTypePhoneNumber : 2,
    CXHandleType.CXHandleTypeEmailAddress : 3
  };

  static const mapValue = {
    1:CXHandleType.CXHandleTypeGeneric,
    2:CXHandleType.CXHandleTypePhoneNumber,
    3:CXHandleType.CXHandleTypeEmailAddress
  };
  int get value => valueMap[this] ?? -1;
}

extension CXCallEndedReasonExtension on CXCallEndedReason {
  static const valueMap = {
    CXCallEndedReason.CXCallEndedReasonFailed : 1,
    CXCallEndedReason.CXCallEndedReasonRemoteEnded : 2,
    CXCallEndedReason.CXCallEndedReasonUnanswered : 3,
    CXCallEndedReason.CXCallEndedReasonAnsweredElsewhere: 4,
    CXCallEndedReason.CXCallEndedReasonDeclinedElsewhere: 5
  };

  static const mapValue = {
    1:CXCallEndedReason.CXCallEndedReasonFailed,
    2:CXCallEndedReason.CXCallEndedReasonRemoteEnded,
    3:CXCallEndedReason.CXCallEndedReasonUnanswered,
    4:CXCallEndedReason.CXCallEndedReasonAnsweredElsewhere,
    5:CXCallEndedReason.CXCallEndedReasonDeclinedElsewhere
  };
  int get value => valueMap[this] ?? -1;
}



extension CXPlayDTMFCallActionTypeExtension on CXPlayDTMFCallActionType {
  static const valueMap = {
    CXPlayDTMFCallActionType.CXPlayDTMFCallActionTypeSingleTone : 1,
    CXPlayDTMFCallActionType.CXPlayDTMFCallActionTypeSoftPause : 2,
    CXPlayDTMFCallActionType.CXPlayDTMFCallActionTypeHardPause : 3
  };

  static const mapValue = {
    1:CXPlayDTMFCallActionType.CXPlayDTMFCallActionTypeSingleTone,
    2:CXPlayDTMFCallActionType.CXPlayDTMFCallActionTypeSoftPause,
    3:CXPlayDTMFCallActionType.CXPlayDTMFCallActionTypeHardPause
  };
  int get value => valueMap[this] ?? -1;
}

extension CXActionImplExtension on CXActionImpl{
  static const subclassTypeSet = <Type>{
    CXActionImpl,
    CXCallActionImpl,
    CXStartCallActionImpl,
    CXAnswerCallActionImpl,
    CXEndCallActionImpl,
    CXSetHeldCallActionImpl,
    CXSetMutedCallActionImpl,
    CXSetGroupCallActionImpl,
    CXPlayDTMFCallActionImpl
  };
}

extension CXCallActionImplExtension on CXCallActionImpl{
  static const subclassTypeSet = <Type>{
    CXCallActionImpl,
    CXStartCallActionImpl,
    CXAnswerCallActionImpl,
    CXEndCallActionImpl,
    CXSetHeldCallActionImpl,
    CXSetMutedCallActionImpl,
    CXSetGroupCallActionImpl,
    CXPlayDTMFCallActionImpl
  };
}