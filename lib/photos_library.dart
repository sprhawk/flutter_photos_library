import 'dart:async';

import 'package:flutter/services.dart';

enum AuthorizationStatus {
  NotDetermined,
  Authorized,
  Denied,
  Undefined,
}

class PhotosLibrary {
  static const MethodChannel _channel =
      const MethodChannel('flutter.yang.me/photos_library');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<AuthorizationStatus> get authorizeationStatus async {
    final int status = await _channel.invokeMethod('getAuthorizationStatus');
    return statusIntToAuthorizationStatus(status);
  }

  static AuthorizationStatus statusIntToAuthorizationStatus(final int status) {
    switch (status) {
      case 0:
        return AuthorizationStatus.NotDetermined;
      case 2:
        return AuthorizationStatus.Denied;
      case 3:
        return AuthorizationStatus.Authorized;
    }

    return AuthorizationStatus.Undefined;
  }

  static Future<AuthorizationStatus> get requestAuthorization async {
      final int status = await _channel.invokeMethod('requestAuthorization');
      return statusIntToAuthorizationStatus(status);
  }
}
