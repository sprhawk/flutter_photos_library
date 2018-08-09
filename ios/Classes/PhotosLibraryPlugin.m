#import "PhotosLibraryPlugin.h"
@import Photos;

@interface PHAsset (FlutterObject)
- (NSDictionary *)assetDictionary;
@end

@interface PhotosLibraryPlugin ()
@end

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
  else if([@"fetchMediaWithType" isEqualToString:call.method]) {
      if(call.arguments && [call.arguments isKindOfClass:[NSArray class]]) {
          NSArray* arguments = call.arguments;
          if(1 == arguments.count) {
              NSNumber *typeN = arguments[0];
              int type = typeN.intValue;
              PHAssetMediaType mediaType = PHAssetMediaTypeUnknown;
              switch (type) {
                  case 1:
                      mediaType = PHAssetMediaTypeImage;
                      break;
                  case 2:
                      mediaType = PHAssetMediaTypeVideo;
                      break;
                  case 0:
                  default:
                      // cannot handle unknown type
                      break;
              }
              if(PHAssetMediaTypeUnknown != mediaType) {
                  PHFetchResult<PHAsset *>* fetchedResults = [PHAsset fetchAssetsWithMediaType:mediaType options:nil];
                  NSMutableArray* assets = [NSMutableArray arrayWithCapacity:fetchedResults.count];
                  for (PHAsset* asset in fetchedResults) {
                      [assets addObject:asset.assetDictionary];
                  }
                  result([assets copy]);
              }
          }
      }
      result(FlutterMethodNotImplemented);
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end

@implementation PHAsset(FlutterObject)
- (NSDictionary *)assetDictionary
{
    return @{
             @"identifier": self.localIdentifier,
             @"width": @(self.pixelWidth),
             @"height": @(self.pixelHeight),
             @"type": @(self.mediaType),
             @"subtype": @(self.mediaSubtypes),
             @"sourcetype": @(self.sourceType),
             };
}
@end
