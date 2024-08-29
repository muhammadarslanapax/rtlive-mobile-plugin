import 'dart:async';

import 'package:flutter/services.dart';

class CallkitSettings {
  static const MethodChannel channel = MethodChannel("zego_callkit");
  static const EventChannel eventChannel = EventChannel('zego_callkit_event_handler');
  static StreamSubscription<dynamic>? streamSubscription;
}
