package com.lyg.flutter_alpha_player_plugin

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeAlphaPlayerFactory(binaryMessenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private val mBinaryMessenger = binaryMessenger;

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String, Any>?
        return NativeAlphaPlayer(mBinaryMessenger, context, viewId, params)
    }
}