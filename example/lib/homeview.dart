import 'package:flutter/material.dart';
import 'package:photos_library/photos_library.dart';
import 'package:photos_library/asset.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeView> {
  final _assets = List<Asset>();
  bool _firstRun = true;
  PhotosLibraryAuthorizationStatus _status = PhotosLibraryAuthorizationStatus.NotDetermined;

  Widget buildStatus(BuildContext context) {
    String statusString = "Unknown status";
    switch (_status) {
      case PhotosLibraryAuthorizationStatus.Authorized:
        statusString = "Authorized";
        break;
      case PhotosLibraryAuthorizationStatus.Denied:
        statusString = "Denied";
        break;
      case PhotosLibraryAuthorizationStatus.NotDetermined:
        statusString = "Not Determined";
        break;
      default:
        statusString = "Undefined";
    }

    return Text(statusString);
  }

  @override
  void initState() {
    super.initState();
    refreshStatus();
  }

  void refreshStatus() async {
    try {
      _status = await PhotosLibrary.authorizeationStatus;
      print("status: $_status");
      setState(() {});
    } catch (e) {}
  }

  void requestAuthorization() async {
    try {
      _status = await PhotosLibrary.requestAuthorization;
      setState(() {});
    }
    catch(e) {}
  }

  void loadAssets() async {
    print("loadAssets");
    try {
      var assets = await PhotosLibrary.fetchMediaWithType(PhotosLibraryMediaType.Photo);
      setState(() {
        _assets.clear();
        _assets.addAll(assets);
      });
    }
    catch(e) {}
  }

  @override
  Widget build(BuildContext context) {
    if(_firstRun) {
      refreshStatus();
      _firstRun = false;
    }
    return Column(
      children: <Widget>[
        Center(
          child: Text("Photos Library Authorization status:"),
        ),
        Center(child: buildStatus(context)),
        RaisedButton(
          child: Text("Authorize"),
          onPressed: requestAuthorization,
        ),
        RaisedButton(
          child: Text("Load Assets"),
          onPressed: loadAssets,
        )
        /*
        Container(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(100, (index) {
              return Center(
                  child: Text(
                'Item: $index',
                style: Theme.of(context).textTheme.headline,
              ));
            }),
          ),
        )
        */
      ],
    );
  }
}
