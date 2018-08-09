import 'package:flutter/material.dart';
import 'package:photos_library/asset.dart';

class AssetView extends StatefulWidget {
  final int _index;
  final Asset _asset;

  AssetView(this._index, this._asset);

  @override
  State<StatefulWidget> createState() => AssetState(this._index, this._asset);
}

class AssetState extends State<AssetView> {
  int _index = 0;
  Asset _asset;
  AssetState(this._index, this._asset);

  @override
  void initState() {
    super.initState();

    this._asset.requestThumbnail(1000, 1000, (imageData) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (null != this._asset.imageData) {
      return Image.memory(
        this._asset.imageData.buffer.asUint8List(),
        fit: BoxFit.cover,
      );
    }

    return Text(
      '${this._index}',
      style: Theme.of(context).textTheme.headline,
    );
  }
}
