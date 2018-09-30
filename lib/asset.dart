import 'package:flutter/services.dart';
import 'photos_library.dart';

class Asset {
  final String identifier;
  final int width;
  final int height;
  ByteData imageData;

  String channelName;

  Asset({this.identifier, this.width, this.height}) {
    const prefix = 'flutter.yang.me/photos_library/image';
    this.channelName = prefix + '/' + this.identifier;
  }

  void requestThumbnail(int width, int height, void handler(ByteData imageData)) {
    BinaryMessages.setMessageHandler(channelName, (message) {
      this.imageData = message;
      handler(message);
      // BinaryMessages.setMessageHandler(channelName, null);
    });

    PhotosLibrary.requestThumbnail(this.identifier, width, height);
  }
}
