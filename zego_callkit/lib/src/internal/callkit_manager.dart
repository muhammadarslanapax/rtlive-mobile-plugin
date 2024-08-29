import '../internal/callkit_converter.dart';
import '../internal/callkit_settings.dart';
import 'callkit_engine.dart';
import '../zego_callkit_defines.dart';

class CallKitManager {

  static CallkitEngine? _instanceEngine;

  static _initialize(){
    _instanceEngine ??= CallkitEngine();
  }

  static CallkitEngine getInstance() {
    _instanceEngine ??= CallkitEngine();
    return _instanceEngine!;
  }

  static setInitConfiguration(CXProviderConfiguration configuration){
    _initialize();
    CallkitSettings.channel.invokeMethod('setInitConfig',{'config':CallkitConverter.mCXProviderConfiguration(configuration),'isStatic':true});
  }
}