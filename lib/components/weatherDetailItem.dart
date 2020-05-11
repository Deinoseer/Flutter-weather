import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final value;
  final Object icon;
  final String unit;
  final String tooltip;

  const WeatherDetailItem({
    Key key,
    this.value,
    this.icon,
    this.unit,
    this.tooltip = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      decoration: BoxDecoration(color: Colors.red, boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ]),
      message: tooltip,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28.0,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            unit,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
