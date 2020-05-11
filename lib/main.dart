import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'detail.dart';
import 'utils/helper.dart';
import 'components/bottomDetail.dart';
import 'components/weatherDetailItem.dart';
import 'components/temperatureDetail.dart';
import 'components/cityDetail.dart';
import 'components/searchCity.dart';

Future _checkLocationPremission() async {
  return await Geolocator().checkGeolocationPermissionStatus();
}

Future _getGeoPos() async {
  return await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
}

Future _getAddress(lat, long) async {
  return await Geolocator().placemarkFromCoordinates(lat, long);
}

Future _getLocation() async {
  return await _checkLocationPremission().then((premission) {
    print(premission);
    if (premission == GeolocationStatus.granted) {
      return _getGeoPos().then((position) {
        print(position);
        return {
          'lat': position.latitude.toString(),
          'long': position.longitude.toString()
        };
      });
    }
    return null;
  });
}

Future _getWeather() async {
  return await _getLocation().then((position) {
    const String apiKey = '21892ec65336604b54a1ee59914379a7';
    var latitude = position['lat'];
    var longitude = position['long'];
    var url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,hourly&units=metric&appid=$apiKey';
    return http.get(url);
  });
}

Future getWeather() {
  return _getWeather().then((response) {
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }).catchError((error) {
    debugPrint(error);
  });
}

void main() => runApp(WeatherApp());
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

class WeatherApp extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: appBar,
        body: _buildBody(),
        backgroundColor: Colors.red,
      ),
      routes: {
        '/detail-page': (context) => DetailPage(),
      },
    );
  }
}

Widget _buildBody() {
  final dateNow = new DateTime.now();
  String dateFormat =
      DateFormat('EEEE, MMM d, yyyy').format(dateNow); // TODO translate to lang

  return SingleChildScrollView(
    child: FutureBuilder(
      future: getWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final weekForecast = snapshot.data['daily'];
          final icon = snapshot.data['current']['weather'][0]['main'];
          final weatherDesc =
              snapshot.data['current']['weather'][0]['description'];
          final currTemp = snapshot.data['current']['temp'].round();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SearchCity(),
              CityDetail(
                  location: snapshot.data['timezone'],
                  date: dateFormat), //'Vologodskaya Oblast, RU'
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 38.0),
                child: TemperatureDetail(
                  icon: Icon(
                    weatherIcon(icon),
                    size: 50,
                    color: Colors.white,
                  ),
                  temperature: '$currTemp °C',
                  weather: toBeginningOfSentenceCase(weatherDesc),
                ),
              ),
              _extraWeatherDetail(
                feelsLike: snapshot.data['current']['feels_like'],
                windSpeed: snapshot.data['current']['wind_speed'],
                humidity: snapshot.data['current']['humidity'],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: BottomDetail(daily: weekForecast),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          throw snapshot.error;
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        }
      },
    ),
  );
}

Row _extraWeatherDetail({feelsLike = 0, windSpeed = 0, humidity = 0}) {
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
