#import "UgsvFlutterPlugin.h"

#import "UGCKit.h"
#import "HUDHelper.h"
#import "TCUtil.h"
#import <Bugly/Bugly.h>
#import "SDKHeader.h"
#import <XMagic/TELicenseCheck.h>
#import <TXLiteAVSDK_Professional/TXLiveBase.h>
#import <TXLiteAVSDK_Professional/TXUGCBase.h>

#import "UGCKit.h"
#import "TCLoginModel.h"
#import "TCLoginParam.h"
#import "HUDHelper.h"
#import "TCUtil.h"
#import "UIView+Additions.h"
#import "TCNavigationController.h"
#import "PhotoUtil.h"
// #import "TXUGCPublish.h"
#import "SDKHeader.h"
#import "TCUserInfoModel.h"
#import "UGCKitWrapper.h"
#import "Mem.h"

#import "UgsvFlutterCallback.h"

@interface UgsvFlutterPlugin () <FlutterStreamHandler>
@property(strong, nonatomic) UGCKitWrapper *ugcWrapper;
@end


static NSDictionary *methods;

@implementation UgsvFlutterPlugin {
    UGCKitTheme *_theme;
}
- (FlutterError *)onListenWithArguments:(id)arguments
                                       eventSink:(FlutterEventSink)events {
    // init callback
    [UgsvFlutterCallback setEventSink:events];
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    return nil;
}

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"ugsv_flutter_test"
                  binaryMessenger:[registrar messenger]];
    UgsvFlutterPlugin *instance = [[UgsvFlutterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    FlutterEventChannel *eventChannel = [FlutterEventChannel 
                                         eventChannelWithName:@"EVENT_CHANNEL_NAME_NATIVE_TO_FLUTTER"
                                         binaryMessenger:registrar.messenger];
    [eventChannel setStreamHandler:instance];
    
    // init callback
    [UgsvFlutterCallback setMethodChannel:channel];

    methods = @{
            @"openVideoChooser": @1,
            @"setUgcLicense": @2,
            @"hasLastRecordPart": @3,
            @"deleteLastRecordPart": @4,
            @"openVideoRecorder": @5,
            @"setXMagicLicense": @6,
            @"openPhotoSlide": @7,
    };
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSNumber *method = methods[call.method];
    switch (method.intValue) {
        case 1: {
            [self openVideoChooser];
            break;
        }
        case 2: {
            NSString *licenseUrl = call.arguments[@"licenseUrl"];
            NSString *licenseKey = call.arguments[@"licenseKey"];
            [self setUgcLicense:licenseUrl licenseKey:licenseKey];
            break;
        }
        case 3: {
            BOOL hasDraft = [self hasLastRecordPart];
            result(@(hasDraft));
            break;
        }
        case 4: {
            [self deleteLastRecordPart];
            break;
        }
        case 5: {
            [self openVideoRecorder];
            break;
        }
        case 6: {
            NSString *licenseUrl = call.arguments[@"licenseUrl"];
            NSString *licenseKey = call.arguments[@"licenseKey"];
            [self setXMagicLicense:licenseUrl licenseKey:licenseKey];
            break;
        }
        case 7: {
            [self openPhotoSlide];
            break;
        }
    }
}

- (void)setUgcLicense:(NSString *)licenseUrl licenseKey:(NSString *)licenseKey {
    _theme = [[UGCKitTheme alloc] init];
    _ugcWrapper = [[UGCKitWrapper alloc] initWithViewController:[UIApplication sharedApplication].delegate.window.rootViewController theme:_theme];
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.unexpectedTerminatingDetectionEnable = YES;
#if DEBUG
    config.channel = @"DEBUG";
#else
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleID isEqualToString:@"com.tencent.fx.xiaoshipin.db"]) {
        config.channel = @"CI";
    } else {
        config.channel = @"AppStore";
    }
#endif
    //    [Bugly startWithAppId:@"6efe67cbad" config:config];
    [TXLiveBase setLicenceURL:licenseUrl key:licenseKey];
    [TXUGCBase setLicenceURL:licenseUrl key:licenseKey];

    [TXLiveBase setLogLevel:LOGLEVEL_VERBOSE];
    [UGCKitReporter registerReporter:[TCUtil class]];
}

- (void)setXMagicLicense:(NSString *)licenseUrl licenseKey:(NSString *)licenseKey {
    [TELicenseCheck setTELicense:licenseUrl key:licenseKey completion:^(NSInteger authresult, NSString *_Nonnull errorMsg) {
        if (authresult == TELicenseCheckOk) {
            NSLog(@"鉴权成功");
        } else {
            NSLog(@"鉴权失败");
        }
    }];
}

- (void)showVideoCutView:(UGCKitResult *)result inNavigationController:(UINavigationController *)nav {
    UGCKitCutViewController *vc = [[UGCKitCutViewController alloc] initWithMedia:result.media theme:_theme];
    __weak __typeof(self) wself = self;
    __weak UINavigationController *weakNavigation = nav;
    vc.completion = ^(UGCKitResult *result, int rotation) {
        if ([result isCancelled]) {
            // [wself dismissViewControllerAnimated:YES completion:nil];
            [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"ugcWrapper: %@", wself.ugcWrapper);
            [wself.ugcWrapper showEditViewController:result rotation:rotation inNavigationController:weakNavigation backMode:TCBackModePop];
        }
    };
    [nav pushViewController:vc animated:YES];
}

- (void)openVideoChooser {
    UGCKitMediaPickerConfig *config = [[UGCKitMediaPickerConfig alloc] init];
    config.mediaType = UGCKitMediaTypeVideo;
    config.maxItemCount = NSIntegerMax;
    UGCKitMediaPickerViewController *imagePickerController = [[UGCKitMediaPickerViewController alloc] initWithConfig:config theme:_theme];
    TCNavigationController *nav = [[TCNavigationController alloc] initWithRootViewController:imagePickerController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak __typeof(self) wself = self;
    __weak UINavigationController *navigationController = nav;
    imagePickerController.completion = ^(UGCKitResult *result) {
        if (!result.cancelled && result.code == 0) {
            [wself showVideoCutView:result inNavigationController:navigationController];
        } else {
            NSLog(@"isCancelled: %c, failed: %@", result.cancelled ? 'y' : 'n', result.info[NSLocalizedDescriptionKey]);
            [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                if (!result.cancelled) {
                    UIAlertController *alert =
                    [UIAlertController alertControllerWithTitle:result.info[NSLocalizedDescriptionKey]
                                                        message:nil
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:nil]];
                    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
                }
            }];
        }
    };
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:NULL];
}

- (void)openVideoRecorder {
    UGCKitRecordConfig *config = [[UGCKitRecordConfig alloc] init];
    UGCKitWatermark *watermark = [[UGCKitWatermark alloc] init];
    watermark.image = [UIImage imageNamed:@"watermark"];
    watermark.frame = CGRectMake(0.01, 0.01, 0.1, 0.3);
    config.watermark = watermark;
    config.recoverDraft = YES;
    [self.ugcWrapper showRecordViewControllerWithConfig:config];
}

- (void)openPhotoSlide {
    UGCKitMediaPickerConfig *config = [[UGCKitMediaPickerConfig alloc] init];
    config.mediaType = UGCKitMediaTypePhoto;
    config.minItemCount = 3;
    config.maxItemCount = NSIntegerMax;
    UGCKitMediaPickerViewController *imagePickerController = [[UGCKitMediaPickerViewController alloc] initWithConfig:config theme:_theme];
    TCNavigationController *nav = [[TCNavigationController alloc] initWithRootViewController:imagePickerController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak __typeof(self) wself = self;
    __weak UINavigationController *navigationController = nav;
    imagePickerController.completion = ^(UGCKitResult *result) {
        if (!result.cancelled && result.code == 0) {
            [wself showVideoCutView:result inNavigationController:navigationController];
        } else {
            NSLog(@"isCancelled: %c, failed: %@", result.cancelled ? 'y' : 'n', result.info[NSLocalizedDescriptionKey]);
            [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        }
    };
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:NULL];
}

- (BOOL)hasLastRecordPart {
    // 检查是否有未完成的录制
    NSArray *cachePathList = [[NSUserDefaults standardUserDefaults] objectForKey:CACHE_PATH_LIST];
    NSString *cacheFolder = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
            stringByAppendingPathComponent:UGCKIT_PARTS_DIR];
    BOOL hasDraft = cachePathList && cachePathList.count > 0;
    if (hasDraft) {
        NSFileManager *manager = [[NSFileManager alloc] init];
        for (NSString *file in cachePathList) {
            if (![manager fileExistsAtPath:[cacheFolder stringByAppendingPathComponent:file]]) {
                hasDraft = NO;
                break;
            }
        }
    }
    return hasDraft;
}

- (void)deleteLastRecordPart {
    // 移除缓存数据
    NSArray *cachePathList = [[NSUserDefaults standardUserDefaults] objectForKey:CACHE_PATH_LIST];
    NSString *cacheFolder = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TXUGC"] stringByAppendingPathComponent:@"TXUGCParts"];
    for (NSInteger i = 0; i < cachePathList.count; i++) {
        NSString *videoPath = [cacheFolder stringByAppendingPathComponent:cachePathList[(NSUInteger) i]];
        [TCUtil removeCacheFile:videoPath];
    }
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:CACHE_PATH_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
