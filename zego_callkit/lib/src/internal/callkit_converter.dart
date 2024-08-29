import 'package:zego_callkit/src/internal/callkit_internal_defines.dart';
import 'package:zego_callkit/src/internal/utils/uuid_impl.dart';

import '../zego_callkit_defines.dart';
import 'callkit_defines_extension.dart';

class CallkitConverter{
  static Map mCXProviderConfiguration(CXProviderConfiguration configuration) {
    Map map = {};
    map['localizedName'] = configuration.localizedName;
    if(configuration.supportsVideo_ != null)map['supportsVideo'] = configuration.supportsVideo_;
    if(configuration.maximumCallsPerCallGroup_ != null)map['maximumCallsPerCallGroup'] = configuration.maximumCallsPerCallGroup_;
    if(configuration.maximumCallGroups_ != null)map['maximumCallGroups'] = configuration.maximumCallGroups_;
    if(configuration.supportedHandleTypes_ != null){
      List<int> baseList = [];
      for(CXHandleType type in configuration.supportedHandleTypes_!){
        baseList.add(CXHandleTypeExtension.valueMap[type]!);
      }
      map['supportedHandleTypes'] = baseList;
    }
    if(configuration.iconTemplateImageName_ != null) {
      map['iconTemplateImageName'] = configuration.iconTemplateImageName_;
    }
    return map;
  }

  static Map mCXHandle(CXHandle cxHandle){
    Map map = {};
    map['type'] = CXHandleTypeExtension.valueMap[cxHandle.type];
    map['value'] = cxHandle.value;
    return map;
  }

  static CXHandle oCXHandle(Map map){
    CXHandle cxHandle = CXHandle(type: CXHandleTypeExtension.mapValue[map['type']]!, value: map['value']);
    return cxHandle;
  }

  static Map mCXCallUpdate(CXCallUpdate cxCallUpdate) {
    Map map = {};
    map['supportsDTMF'] = cxCallUpdate.supportsDTMF??false;
    map['supportsHolding'] = cxCallUpdate.supportsHolding??false;
    map['supportsGrouping'] = cxCallUpdate.supportsGrouping??false;
    map['supportsUngrouping'] = cxCallUpdate.supportsUngrouping??false;
    map['hasVideo'] = cxCallUpdate.hasVideo??false;
    if(cxCallUpdate.remoteHandle != null){
      map['remoteHandle'] = mCXHandle(cxCallUpdate.remoteHandle!);
    }
    map['localizedCallerName'] = cxCallUpdate.localizedCallerName??"";
    return map;
  }



  static dynamic cxActionImplFactory(Map actionMap,String seq,Type type){

      if(!CXActionImplExtension.subclassTypeSet.contains(type)){
        throw("input type is not CXActionImpl");
      }
      if(!CXCallActionImplExtension.subclassTypeSet.contains(type)){
        return CXActionImpl(seq: seq);
      }
      UUIDImpl callUUID = UUIDImpl(uuidString_: actionMap['callUUIDString']);
      switch(type){
        case CXStartCallActionImpl:{
          String contactIdentifier = actionMap['contactIdentifier'];
          CXHandle handle = oCXHandle(actionMap['handle']);
          bool video = actionMap['video'];
          return CXStartCallActionImpl(seq: seq, callUUID: callUUID, contactIdentifier: contactIdentifier, handle: handle, video: video);
        }
        case CXAnswerCallActionImpl:{
          return CXAnswerCallActionImpl(seq: seq, callUUID: callUUID);
        }
        case CXEndCallActionImpl:{
          return CXEndCallActionImpl(seq: seq, callUUID: callUUID);
        }
        case CXSetHeldCallActionImpl:{
          bool onHold = actionMap['onHold'];
          return CXSetHeldCallActionImpl(seq: seq, callUUID: callUUID, onHold: onHold);
        }
        case CXSetMutedCallActionImpl:{
          bool muted = actionMap['muted'];
          return CXSetMutedCallActionImpl(seq: seq, callUUID: callUUID, muted: muted);
        }
        case CXSetGroupCallActionImpl:{
          return CXSetGroupCallActionImpl(seq: seq, callUUID: callUUID);
        }
        case CXPlayDTMFCallActionImpl:{
          String digits = actionMap['digits'];
          CXPlayDTMFCallActionType type = CXPlayDTMFCallActionTypeExtension.mapValue[actionMap['type']]!;
          return CXPlayDTMFCallActionImpl(seq: seq, callUUID: callUUID, digits: digits, type: type);
        }
        default:{
          return CXCallActionImpl(seq: seq, callUUID: callUUID);
        }
      }
  }
}