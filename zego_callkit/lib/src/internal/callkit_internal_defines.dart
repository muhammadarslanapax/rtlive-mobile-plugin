

import 'callkit_settings.dart';

import '../../zego_callkit.dart';

class CXActionImpl implements CXAction{

  String seq;

  @override
  fail() {
    CallkitSettings.channel.invokeMethod('callKitActionFail',{'seq':seq});
  }

  @override
  fulfill() {
    CallkitSettings.channel.invokeMethod('callKitActionFulfill',{'seq':seq});
  }

  CXActionImpl({required this.seq});
}

class CXCallActionImpl extends CXActionImpl implements CXCallAction{
  @override
  UUID callUUID;

  CXCallActionImpl({required String seq,required this.callUUID}) : super(seq: seq);

}

class CXStartCallActionImpl extends CXCallActionImpl implements CXStartCallAction {
  @override
  String contactIdentifier;

  @override
  CXHandle handle;

  @override
  bool video;

  CXStartCallActionImpl({required String seq, required UUID callUUID,required this.contactIdentifier,required this.handle,required this.video}) : super(seq: seq, callUUID: callUUID);

}

class CXAnswerCallActionImpl extends CXCallActionImpl implements CXAnswerCallAction {
  CXAnswerCallActionImpl({required String seq, required UUID callUUID}) : super(seq: seq, callUUID: callUUID);
}

class CXEndCallActionImpl extends CXCallActionImpl implements CXEndCallAction {
  CXEndCallActionImpl({required String seq, required UUID callUUID}) : super(seq: seq, callUUID: callUUID);
}

class CXSetHeldCallActionImpl extends CXCallActionImpl implements CXSetHeldCallAction {

  @override
  bool onHold;

  CXSetHeldCallActionImpl({required String seq, required UUID callUUID,required this.onHold}) : super(seq: seq, callUUID: callUUID);

}

class CXSetMutedCallActionImpl extends CXCallActionImpl implements CXSetMutedCallAction{

  @override
  bool muted;

  CXSetMutedCallActionImpl({required String seq, required UUID callUUID,required this.muted}) : super(seq: seq, callUUID: callUUID);

}

class CXSetGroupCallActionImpl extends CXCallActionImpl implements CXSetGroupCallAction{
  CXSetGroupCallActionImpl({required String seq, required UUID callUUID}) : super(seq: seq, callUUID: callUUID);
}


class CXPlayDTMFCallActionImpl extends CXCallActionImpl implements CXPlayDTMFCallAction{
  @override
  String digits;

  @override
  CXPlayDTMFCallActionType type;

  CXPlayDTMFCallActionImpl({required String seq, required UUID callUUID,required this.digits,required this.type}) : super(seq: seq, callUUID: callUUID);


}

