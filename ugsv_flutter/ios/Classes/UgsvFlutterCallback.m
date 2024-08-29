//
//  UgsvFlutterCallack.m
//  ugsv_flutter
//
//  Created by 陈桐 on 2023/12/5.
//

#import "UgsvFlutterCallback.h"

static FlutterMethodChannel *apiChannel;
static FlutterEventSink callback;

@implementation UgsvFlutterCallback
+ (void)setMethodChannel:(FlutterMethodChannel *)methodChannel {
    apiChannel = methodChannel;
}

+ (void)setEventSink:(FlutterEventSink)sink {
    callback = sink;
}

+ (void)call:(NSString *)method args:(NSDictionary *)args {
    if (apiChannel == nil) return;
    [apiChannel invokeMethod:method arguments:args];
    if (callback == nil) return;
    if (args == nil) {
        args = [NSDictionary dictionary];
    }
    NSMutableDictionary *res = [NSMutableDictionary dictionaryWithDictionary:args];
    [res setObject:method forKey:@"method"];
    callback(res);
}
@end
