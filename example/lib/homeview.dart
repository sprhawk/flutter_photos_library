import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return HomeState();
    }
}

class HomeState extends State<HomeView> {
  final _assets = <String>[];

  @override
    Widget build(BuildContext context) {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(100, (index) {
          return Center(
            child: Text(
            'Item: $index',
            style: Theme.of(context).textTheme.headline,
            )
          );
        }),
      );
    }
}