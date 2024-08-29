import 'package:zego_callkit/src/internal/callkit_event_handler_impl.dart';

import 'utils/uuid_impl.dart';
import 'callkit_converter.dart';
import '../zego_callkit_api.dart';
import '../zego_callkit_defines.dart';
import 'callkit_settings.dart';
import 'callkit_defines_extension.dart';

class CallkitEngine implements CallKit{

  CallkitEngine() {
    CallkitEventHandlerImpl.registerEventHandler();
  }

  @override
  Future<void> reportIncomingCall(CXCallUpdate cxCallUpdate, UUID uuid) async{
    return await CallkitSettings.channel.invokeMethod('reportIncomingCallWithTitle',{'cxCallUpdate':CallkitConverter.mCXCallUpdate(cxCallUpdate),'uuidString':(uuid as UUIDImpl).uuidString});
  }

  @override
  Future<void> reportOutgoingCall(UUID uuid) async{
    return await CallkitSettings.channel.invokeMethod('reportOutgoingCall',{'uuidString':(uuid as UUIDImpl).uuidString});
  }

  @override
  Future<void> reportCallUpdate(CXCallUpdate cxCallUpdate, UUID uuid) async{
    return await CallkitSettings.channel.invokeMethod('reportCallUpdate',{'cxCallUpdate':CallkitConverter.mCXCallUpdate(cxCallUpdate),'uuidString':(uuid as UUIDImpl).uuidString});
  }

  @override
  Future<void> reportCallEnded(CXCallEndedReason endedReason, UUID uuid) async{
    return await CallkitSettings.channel.invokeMethod('reportCallEnded',{'uuidString':(uuid as UUIDImpl).uuidString,'endedReason':CXCallEndedReasonExtension.valueMap[endedReason]});
  }

}