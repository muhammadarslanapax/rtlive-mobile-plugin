//
//  UgsvFlutterCallack.h
//  ugsv_flutter
//
//  Created by 陈桐 on 2023/12/5.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface UgsvFlutterCallback : NSObject
+ (void)setMethodChannel:(FlutterMethodChannel *)methodChannel;
+ (void)setEventSink:(FlutterEventSink)sink;
+ (void)call:(NSString *)method args:(NSDictionary *)args;
@end

NS_ASSUME_NONNULL_END
