//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<integration_test/IntegrationTestPlugin.h>)
#import <integration_test/IntegrationTestPlugin.h>
#else
@import integration_test;
#endif

#if __has_include(<zego_callkit/ZegoCallkitPlugin.h>)
#import <zego_callkit/ZegoCallkitPlugin.h>
#else
@import zego_callkit;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [IntegrationTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntegrationTestPlugin"]];
  [ZegoCallkitPlugin registerWithRegistrar:[registry registrarForPlugin:@"ZegoCallkitPlugin"]];
}

@end
