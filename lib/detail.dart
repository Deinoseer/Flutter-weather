import 'package:flutter/material.dart';

class DayWeather {
  final String date;
  final Object weather;

  DayWeather(this.date, this.weather);
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DayWeather args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather on ${args.date}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(args.date),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Main page'),
            ),
          ),
        ],
      ),
    );
  }
}
