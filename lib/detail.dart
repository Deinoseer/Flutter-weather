import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components/extraWeatherDetail.dart';
import 'package:weather_app/components/temperatureDetail.dart';
import 'components/cityDetail.dart';
import 'package:weather_app/utils/helper.dart';

class DayWeather {
  final DateTime date;
  final Map weather;

  DayWeather(this.date, this.weather);
}

class DetailPage extends StatelessWidget {
  final dateFormat = DateFormat('EEEE, MMM d, yyyy');

  @override
  Widget build(BuildContext context) {
    final DayWeather args = ModalRoute.of(context).settings.arguments;
    final appBarDate = DateFormat('d.MM.y').format(args.date);

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Weather on $appBarDate'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CityDetail(
            location: "Day",
            date: dateFormat.format(args.date),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
            child: Center(
              child: TemperatureDetail(
                icon: Icon(
                  weatherIcon(args.weather['weather'][0]['main']),
                  size: 50,
                  color: Colors.white,
                ),
                temperature: '${args.weather['temp']['day'].round()} °C',
                weather: toBeginningOfSentenceCase(
                    args.weather['weather'][0]['description']),
              ),
            ),
          ),
          ExtraWeatherDetail(
            feelsLike: args.weather['feels_like']['day'].round(),
            windSpeed: args.weather['wind_speed'],
            humidity: args.weather['humidity'],
          ),
        ],
      ),
    );
  }
}
