import 'package:flutter/material.dart';
import 'package:weather_app/components/weatherDetailItem.dart';

class ExtraWeatherDetail extends StatelessWidget {
  final feelsLike;
  final windSpeed;
  final humidity;

  const ExtraWeatherDetail(
      {Key key, this.feelsLike: 0, this.windSpeed: 0, this.humidity: 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Feels Line current.feels_like
    //wind speed meter/sec  current.wind_speed
    //Humidity % current.humidity

    /**
   *  current.sunrise Sunrise time, unix, UTC
   *  current.sunset Sunset time, unix, UTC
   */
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        WeatherDetailItem(
            tooltip: 'Feels like',
            icon: Icons.touch_app,
            value: feelsLike.round(),
            unit: '°C'), //feelslike
        WeatherDetailItem(
            tooltip: 'Wind speed',
            icon: Icons.toys,
            value: windSpeed,
            unit: 'm/sec'), //wind speed
        WeatherDetailItem(
            tooltip: 'Humidity',
            icon: Icons.invert_colors,
            value: humidity,
            unit: '%'), // humidity %
      ],
    );
  }
}
