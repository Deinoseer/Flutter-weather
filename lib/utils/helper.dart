import 'package:flutter/material.dart';

weatherIcon(weather) {
  //TODO https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2
  switch (weather) {
    case 'Clouds':
      {
        return Icons.wb_cloudy;
      }
      break;
    case 'Snow':
      {
        return Icons.ac_unit;
      }
      break;
    case 'Clear':
      {
        return Icons.wb_sunny;
      }
      break;
    case 'Rain':
      {
        return Icons.beach_access;
      }
    default:
      {
        return Icons.remove_circle_outline;
      }
  }
}
