import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:photos_library/asset.dart';

class AssetView extends StatefulWidget {
  final int index;
  final Asset asset;
  final double width;
  final double height;
  AssetView(
      {@required this.index, @required this.asset, this.width, this.height});

  @override
  State<StatefulWidget> createState() => AssetState(
      index: this.index,
      asset: this.asset,
      width: this.width,
      height: this.height);
}

class AssetState extends State<AssetView> {
  int index = 0;
  Asset asset;
  final double width;
  final double height;
  AssetState(
      {@required this.index, @required this.asset, this.width, this.height});

  @override
  void initState() {
    super.initState();

    this.asset.requestThumbnail(this.width.toInt(), this.height.toInt(),
        (imageData) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (null != this.asset.imageData) {
      var image = Image.memory(
        this.asset.imageData.buffer.asUint8List(),
        fit: BoxFit.cover,
        width: this.width,
        height: this.height,
      );

      return image;
    }

    return Text(
      '${this.index}',
      style: Theme.of(context).textTheme.headline,
    );
  }
}
