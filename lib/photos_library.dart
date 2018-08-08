import 'dart:async';

import 'package:flutter/services.dart';

class PhotosLibrary {
  static const MethodChannel _channel =
      const MethodChannel('flutter.me.yang/photos_library');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
