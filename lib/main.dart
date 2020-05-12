import 'package:flutter/material.dart';
import 'home.dart';
import 'detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
      routes: {
        '/detail-page': (context) => DetailPage(),
      },
    );
  }
}
