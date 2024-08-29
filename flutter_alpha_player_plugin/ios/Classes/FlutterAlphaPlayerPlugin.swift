import Flutter
import UIKit

public class FlutterAlphaPlayerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        /// 建立通信通道 用来 监听Flutter 的调用和 调用Fluttter 方法 这里的名称要和Flutter 端保持一致
        let playerPluginFactory = NativeAlphaPlayerFactory(messenger: registrar.messenger())
        /// 这里填写的id 一定要和dart里面的viewType 这个参数传的id一致
        registrar.register(playerPluginFactory, withId: "flutter_alpha_player")
    }
}
