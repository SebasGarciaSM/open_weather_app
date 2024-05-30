import 'package:flutter/material.dart';
import 'package:open_weather_app/models/details_models/details_model.dart';

class WeatherUtil {
  static Widget getWeatherIcon(MainEnum weather, {double size = 24.0}) {
    switch (weather) {
      case MainEnum.CLEAR:
        return Icon(
          Icons.sunny,
          color: Colors.orange,
          size: size,
        );
      case MainEnum.RAIN:
        return Icon(
          Icons.water_drop,
          color: Colors.blue,
          size: size,
        );
      case MainEnum.CLOUDS:
        return Icon(
          Icons.cloud,
          color: Colors.grey,
          size: size,
        );

      default:
        return Container();
    }
  }

  static String getTemperature(double? temperature) {
    if (temperature != null) {
      String roundedTemperature = "${temperature.round().toString()}°";
      return roundedTemperature;
    } else {
      return '';
    }
  }

  static bool isToday(dynamic item) {
    if (item.dtTxt?.day == DateTime.now().day &&
        item.dtTxt?.month == DateTime.now().month &&
        item.dtTxt?.year == DateTime.now().year) {
      return true;
    } else {
      return false;
    }
  }
}
