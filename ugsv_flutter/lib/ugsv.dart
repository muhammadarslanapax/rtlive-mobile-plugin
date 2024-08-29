import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class UGSV {
  static const MethodChannel _apiChannel = MethodChannel("ugsv_flutter_test");

  static EventChannel? eventChannel = null;

  static final StreamController<String> _editorEventNotifier =
  StreamController<String>.broadcast();

  static Future<void> _handleCallback(MethodCall call) async {
    print("_handleCallback    ${call.arguments["outputPath"]}");
    switch (call.method) {
      case "onEditCompleted":
        {
          String json = jsonEncode({
            "method": call.method,
            "outputPath": call.arguments["outputPath"],
          });
          _editorEventNotifier.add(json);
          break;
        }
    }
  }

  static void _onEventChannelCallbackData(parameter) {
    print("_onEventChannelCallbackData ");
    String json = jsonEncode({
      "method": parameter["method"],
      "outputPath": parameter["outputPath"],
    });
    _editorEventNotifier.add(json);
  }

  static initCallback() {
    print("FLUTTER:Init FLUTTER CALLBACK");
    if (eventChannel == null) {
      eventChannel = EventChannel("EVENT_CHANNEL_NAME_NATIVE_TO_FLUTTER");
      eventChannel!
          .receiveBroadcastStream()
          .listen(_onEventChannelCallbackData);
    }
    // if (Platform.isAndroid) {
    //   if (eventChannel == null) {
    //     eventChannel = EventChannel("EVENT_CHANNEL_NAME_NATIVE_TO_FLUTTER");
    //     eventChannel!
    //         .receiveBroadcastStream()
    //         .listen(_onEventChannelCallbackData);
    //   }
    // } else if (Platform.isIOS) {
    //   _apiChannel.setMethodCallHandler(_handleCallback);
    // }
  }

  static EditorEventListener registerEditorEventListener({
    void Function(Map<String, dynamic> json) onEditCompleted = _defaultOnEditCompleted,
  }) {
    return EditorEventListener(
      listener: _editorEventNotifier.stream.listen((event) {
        Map<String, dynamic> json = jsonDecode(event);
        String method = json["method"];
        switch (method) {
          case "onEditCompleted":
            {
              onEditCompleted(json);
              break;
            }
        }
      }),
    );
  }

  static openVideoChooser() {
    _apiChannel.invokeMethod("openVideoChooser", {});
  }

  static openVideoRecorder() {
    _apiChannel.invokeMethod("openVideoRecorder", {});
  }

  static openPhotoSlide() {
    _apiChannel.invokeMethod("openPhotoSlide", {});
  }

  static Future<bool> hasLastRecordPart() async {
    return await _apiChannel.invokeMethod("hasLastRecordPart", {});
  }

  static deleteLastRecordPart() {
    _apiChannel.invokeMethod("deleteLastRecordPart", {});
  }

  static setUgcLicense({
    required String licenseUrl,
    required String licenseKey,
  }) {
    _apiChannel.invokeMethod("setUgcLicense", {
      "licenseUrl": licenseUrl,
      "licenseKey": licenseKey,
    });
  }

  static setTELicense({
    required String licenseUrl,
    required String licenseKey,
  }) {
    _apiChannel.invokeMethod("setXMagicLicense", {
      "licenseUrl": licenseUrl,
      "licenseKey": licenseKey,
    });
  }

  static getLicenseInfo({
    required String licenseUrl,
    required String licenseKey,
  }) {
    return _apiChannel.invokeMethod("getLicenseInfo");
  }
}

class EditorEventListener {
  StreamSubscription? _editorEventListener;

  EditorEventListener({required StreamSubscription listener}) {
    _editorEventListener = listener;
  }

  unregister() {
    _editorEventListener?.cancel();
  }
}

_defaultOnEditCompleted(String) {}
