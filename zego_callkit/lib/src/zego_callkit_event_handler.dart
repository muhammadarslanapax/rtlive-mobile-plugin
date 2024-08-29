import '../zego_callkit.dart';
class CallKitEventHandler{


  ///This method is invoked when a push notification has been received for the specified PKPushType.
  ///[extras] The push extras sent by a developer via APNS server API.
  static void Function(Map extras, UUID uuid)? didReceiveIncomingPush;

  /// Called when the provider has been reset. Delegates must respond to this callback by cleaning up all internal call state (disconnecting communication channels, releasing network resources, etc.). This callback can be treated as a request to end all calls without the need to respond to any actions
  static void Function()? providerDidReset;

  /// Called when the provider has been fully created and is ready to send actions and receive updates
  static void Function()? providerDidBegin;

  /// Called when the provider's audio session activation state changes.
  static void Function()? didActivateAudioSession;

  static void Function()? didDeactivateAudioSession;


  /// Called when an action was not performed in time and has been inherently failed. Depending on the action, this timeout may also force the call to end. An action that has already timed out should not be fulfilled or failed by the provider delegate
  static void Function(CXAction action)? timedOutPerformingAction;


  /// each perform*CallAction method is called sequentially for each action in the transaction
  static void Function(CXStartCallAction action)? performStartCallAction;

  static void Function(CXAnswerCallAction action)? performAnswerCallAction;

  static void Function(CXEndCallAction action)? performEndCallAction;

  static void Function(CXSetHeldCallAction action)? performSetHeldCallAction;

  static void Function(CXSetMutedCallAction action)? performSetMutedCallAction;

  static void Function(CXSetGroupCallAction action)? performSetGroupCallAction;

  static void Function(CXPlayDTMFCallAction action)? performPlayDTMFCallAction;
}