import 'package:flutter/material.dart';

class TemperatureDetail extends StatelessWidget {
  final String weather;
  final String temperature;
  final Object icon;

  const TemperatureDetail({
    this.icon,
    this.temperature,
    this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: icon,
              ),
              Text(
                temperature,
                style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              ),
            ],
          ),
          Text(
            weather,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
