import 'package:flutter/material.dart';

class CityDetail extends StatelessWidget {
  final String location;
  final String date;

  const CityDetail({
    this.location,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text(
            location,
            style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          child: Text(
            date,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}
