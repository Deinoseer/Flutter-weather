import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app/components/extraWeatherDetail.dart';
import 'package:weather_app/utils/apiService.dart';
import 'package:weather_app/utils/helper.dart';
import 'package:weather_app/components/bottomDetail.dart';
import 'package:weather_app/components/temperatureDetail.dart';
import 'package:weather_app/components/cityDetail.dart';
import 'package:weather_app/components/searchCity.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBody createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  bool _loading = true;
  Position _currentPosition;
  String _currentAddress;
  Map _weatherData;

  @override
  void initState() {
    super.initState();
    getLocation().then((position) {
      setState(() {
        _currentPosition = position;
      });
      getAddress(_currentPosition.latitude, _currentPosition.longitude)
          .then((address) {
        Placemark place = address[0];
        setState(() {
          _currentAddress = "${place.locality}, ${place.country}";
          print(_currentAddress);
        });
      });
      getWeather(_currentPosition.latitude, _currentPosition.longitude)
          .then((weather) {
        Map<String, dynamic> weaterData = jsonDecode(weather.body);
        setState(() {
          _loading = false;
          _weatherData = weaterData;
        });
      });
    });
  }

  DateTime dateNow = new DateTime.now();
  final dateFormat = DateFormat('EEEE, MMM d, yyyy');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SearchCity(),
            if (_loading == true) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            ],
            if (_currentAddress != null)
              CityDetail(
                location: _currentAddress,
                date: dateFormat.format(dateNow),
              ),
            if (_weatherData != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                child: Center(
                  child: TemperatureDetail(
                    icon: Icon(
                      weatherIcon(
                          _weatherData['current']['weather'][0]['main']),
                      size: 50,
                      color: Colors.white,
                    ),
                    temperature:
                        '${_weatherData['current']['temp'].round()} °C',
                    weather: toBeginningOfSentenceCase(
                        _weatherData['current']['weather'][0]['description']),
                  ),
                ),
              ),
              ExtraWeatherDetail(
                feelsLike: _weatherData['current']['feels_like'],
                windSpeed: _weatherData['current']['wind_speed'],
                humidity: _weatherData['current']['humidity'],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: BottomDetail(daily: _weatherData['daily']),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
