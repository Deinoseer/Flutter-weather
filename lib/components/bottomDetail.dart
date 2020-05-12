import 'package:flutter/material.dart';
import 'package:weather_app/utils/helper.dart';
import 'package:weather_app/detail.dart';
import 'package:intl/intl.dart';

class BottomDetail extends StatelessWidget {
  final List<dynamic> daily;

  const BottomDetail({
    this.daily,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            '7-DAY WEATHER FORECAST',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(daily.length, (index) {
              if (index == 0) {
                return Divider(); //SizedBox
              }
              var dateFormat = DateTime.fromMillisecondsSinceEpoch(
                  daily[index]['dt'] * 1000);
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/detail-page",
                    arguments: DayWeather(
                        DateFormat('d.MM.y').format(dateFormat), daily[index]),
                  );
                },
                child: BottomDetailItem(
                  date: DateFormat('d.MM.y').format(dateFormat),
                  day: DateFormat('EEEE').format(dateFormat),
                  value: '${daily[index]['temp']['day'].round()} °C',
                  icon: Icon(
                    weatherIcon(daily[index]['weather'][0]['main']),
                    color: Colors.white,
                    size: 26.0,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class BottomDetailItem extends StatelessWidget {
  final String day;
  final String value;
  final String date;
  final Object icon;

  const BottomDetailItem({
    Key key,
    this.day,
    this.date,
    this.value,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: Card(
        color: Colors.redAccent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                day,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                date,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(value,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300)),
                  Padding(
                    child: icon,
                    padding: EdgeInsets.only(left: 12.0),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
