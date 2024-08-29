package com.tencent.ugsv_flutter;

import io.flutter.plugin.common.MethodChannel;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
import android.os.Handler;
import android.os.Looper;
import io.flutter.plugin.common.EventChannel;

public class FlutterCallback {

    private static EventChannel.EventSink mEventSink;
    private static MethodChannel apiChannel;
    private static Handler handler = new Handler(Looper.getMainLooper());

    public static void init(EventChannel.EventSink sink) {
        FlutterCallback.mEventSink = sink;
    }

    public static void call(String method, Map args) {
        if (FlutterCallback.mEventSink == null) {
            return;
        }
        if (args == null) {
            args = new HashMap();
        }
        args.put("method", method);
        FlutterCallback.mEventSink.success(args);
    }
}
