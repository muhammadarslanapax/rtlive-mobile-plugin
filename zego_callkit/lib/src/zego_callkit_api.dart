import 'internal/callkit_manager.dart';
import 'zego_callkit_defines.dart';

abstract class CallKit {

  static setInitConfiguration(CXProviderConfiguration configuration){
    return CallKitManager.setInitConfiguration(configuration);
  }

  static CallKit getInstance() {
    return CallKitManager.getInstance();
  }

  /// Report a new incoming call to the system.
  Future<void> reportIncomingCall(CXCallUpdate cxCallUpdate, UUID uuid);

  /// Report that an outgoing call started connecting.
  Future<void> reportOutgoingCall(UUID uuid);

  /// Report an update to call information.
  Future<void> reportCallUpdate(CXCallUpdate cxCallUpdate,UUID uuid);

  /// Report that a call ended. A nil value for `dateEnded` results in the ended date being set to now.
  Future<void>reportCallEnded(CXCallEndedReason endedReason,UUID uuid);
}