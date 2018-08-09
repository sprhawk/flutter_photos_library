import 'package:flutter/material.dart';
import 'package:photos_library/photos_library.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeView> {
  final _assets = <String>[];
  bool _firstRun = true;
  AuthorizationStatus _status = AuthorizationStatus.NotDetermined;

  Widget buildStatus(BuildContext context) {
    String statusString = "Unknown status";
    switch (_status) {
      case AuthorizationStatus.Authorized:
        statusString = "Authorized";
        break;
      case AuthorizationStatus.Denied:
        statusString = "Denied";
        break;
      case AuthorizationStatus.NotDetermined:
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
