import 'package:flutter/services.dart';
import 'photos_library.dart';

class Asset {
  String identifier;
  int width;
  int height;
  ByteData imageData;

  void requestThumbnail(int width, int height, void handler(ByteData imageData)) {
    const prefix = 'flutter.yang.me/photos_library/image';
    var channelName = prefix + '/' + this.identifier;

    BinaryMessages.setMessageHandler(channelName, (message) {
      this.imageData = message;
      handler(message);
      BinaryMessages.setMessageHandler(channelName, null);
    });

    PhotosLibrary.requestThumbnail(this.identifier, width, height);
  }
}
