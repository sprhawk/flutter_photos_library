#import "PhotosLibraryPlugin.h"
@import Photos;

@implementation PhotosLibraryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter.yang.me/photos_library"
            binaryMessenger:[registrar messenger]];
  PhotosLibraryPlugin* instance = [[PhotosLibraryPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  else if([@"getAuthorizationStatus" isEqualToString:call.method]) {
      PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
      result(@(status));
      
  }
  else if([@"requestAuthorization" isEqualToString:call.method]) {
      [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
          result(@(status));
      }];
      
  }
  else if([@"getAssets" isEqualToString:call.method]) {
      
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
