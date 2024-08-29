import 'package:zego_callkit/src/internal/callkit_converter.dart';
import '../zego_callkit_event_handler.dart';
import 'callkit_settings.dart';
import 'utils/uuid_impl.dart';
import 'callkit_internal_defines.dart';
class CallkitEventHandlerImpl implements CallKitEventHandler {
  static void registerEventHandler() async {
    CallkitSettings.streamSubscription ??=
        CallkitSettings.eventChannel.receiveBroadcastStream().listen(eventListener);
  }

  static void unregisterEventHandler() async {
    await CallkitSettings.streamSubscription?.cancel();
    CallkitSettings.streamSubscription = null;
  }

  static void eventListener(dynamic data) {
    final Map<dynamic, dynamic> map = data;
    switch (map['method']) {
      case 'didReceiveIncomingPushWithPayload':
        if(CallKitEventHandler.didReceiveIncomingPush == null)return;
        CallKitEventHandler.didReceiveIncomingPush!(map['payload']??{},UUIDImpl(uuidString_: map['uuidString']));
        break;
      case 'providerDidReset':
        if(CallKitEventHandler.providerDidReset == null) return;
        CallKitEventHandler.providerDidReset!();
        break;
      case 'providerDidBegin':
        if(CallKitEventHandler.providerDidBegin == null) return;
        CallKitEventHandler.providerDidBegin!();
        break;
      case 'didActivateAudioSession':
        if(CallKitEventHandler.didActivateAudioSession == null) return;
        CallKitEventHandler.didActivateAudioSession!();
        break;
      case 'didDeactivateAudioSession':
        if(CallKitEventHandler.didDeactivateAudioSession == null) return;
        CallKitEventHandler.didDeactivateAudioSession!();
        break;
      case 'timedOutPerformingAction':
        if(CallKitEventHandler.timedOutPerformingAction == null) return;
        CallKitEventHandler.timedOutPerformingAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXActionImpl));
        break;
      case 'executeTransaction':
       //if(CallKitEventHandler.executeTransaction == null) return;
      // CallKitEventHandler.executeTransaction!(CXActionImpl(seq: map['seq']));
        break;
      case 'performStartCallAction':
        if(CallKitEventHandler.performStartCallAction == null) return;
        CallKitEventHandler.performStartCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXStartCallActionImpl));
        break;
      case 'performAnswerCallAction':
        if(CallKitEventHandler.performAnswerCallAction == null) return;
        CallKitEventHandler.performAnswerCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXAnswerCallActionImpl));
        break;
      case 'performEndCallAction':
        if(CallKitEventHandler.performEndCallAction == null) return;
        CallKitEventHandler.performEndCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXEndCallActionImpl));
        break;
      case 'performSetHeldCallAction':
        if(CallKitEventHandler.performSetHeldCallAction == null) return;
        CallKitEventHandler.performSetHeldCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXSetHeldCallActionImpl));
        break;
      case 'performSetMutedCallAction':
        if(CallKitEventHandler.performSetMutedCallAction == null) return;
        CallKitEventHandler.performSetMutedCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXSetMutedCallActionImpl));
        break;
      case 'performSetGroupCallAction':
        if(CallKitEventHandler.performSetGroupCallAction == null) return;
        CallKitEventHandler.performSetGroupCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'],CXSetGroupCallActionImpl));
        break;
      case 'performPlayDTMFCallAction':
        if(CallKitEventHandler.performPlayDTMFCallAction == null) return;
        CallKitEventHandler.performPlayDTMFCallAction!(CallkitConverter.cxActionImplFactory(map['action'], map['seq'], CXPlayDTMFCallActionImpl));
        break;
      default:
    }

  }
}