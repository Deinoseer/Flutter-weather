import 'package:flutter/material.dart';
import 'package:weather_app/components/homeBody.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppBar appBar = AppBar(
    title: Text(
      'Weather Forecast',
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Colors.red,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.menu),
    ),
    brightness: Brightness.light,
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.settings),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.red,
      body: HomeBody(),
    );
  }
}
