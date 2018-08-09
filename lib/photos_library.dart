import 'dart:async';

import 'package:flutter/services.dart';
import 'asset.dart';

enum PhotosLibraryAuthorizationStatus {
  NotDetermined,
  Authorized,
  Denied,
  Undefined,
}

enum PhotosLibraryMediaType {
  Unknown,
  Photo,
  Video,
}

class PhotosLibrary {
  static const MethodChannel _channel =
      const MethodChannel('flutter.yang.me/photos_library');

  static PhotosLibraryAuthorizationStatus _statusIntToAuthorizationStatus(final int status) {
    switch (status) {
      case 0:
        return PhotosLibraryAuthorizationStatus.NotDetermined;
      case 2:
        return PhotosLibraryAuthorizationStatus.Denied;
      case 3:
        return PhotosLibraryAuthorizationStatus.Authorized;
    }

    return PhotosLibraryAuthorizationStatus.Undefined;
  }

  static Future<PhotosLibraryAuthorizationStatus> get authorizeationStatus async {
    final int status = await _channel.invokeMethod('getAuthorizationStatus');
    return _statusIntToAuthorizationStatus(status);
  }

  static Future<PhotosLibraryAuthorizationStatus> get requestAuthorization async {
      final int status = await _channel.invokeMethod('requestAuthorization');
      return _statusIntToAuthorizationStatus(status);
  }

  static Future<List<Asset>> fetchMediaWithType(PhotosLibraryMediaType type) async {
    List<Map> results = await _channel.invokeMethod("fetchMediaWithType", [type.index]);
    var assets = List<Asset>();
    for (var item in results) {
      var asset = Asset();
      asset.identifier = item['identifier'];
      asset.width = item['width'];
      asset.height = item['height'];
      assets.add(asset);
    }
    return assets;
  }
}
