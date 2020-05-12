import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future _checkLocationPremission() async {
  return await Geolocator().checkGeolocationPermissionStatus();
}

Future getGeoPos() async {
  return await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
}

Future getAddress(lat, long) async {
  return await Geolocator().placemarkFromCoordinates(lat, long);
}

Future getLocation() async {
  return await _checkLocationPremission().then((premission) {
    print(premission);
    if (premission == GeolocationStatus.granted) {
      return getGeoPos().then((position) {
        print(position);
        return position;
      });
    }
    return null;
  });
}

Future getWeather(lat, long) async {
  const String apiKey = '21892ec65336604b54a1ee59914379a7';
  var url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly&units=metric&appid=$apiKey';
  return http.get(url);
}
