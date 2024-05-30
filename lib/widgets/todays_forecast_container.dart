import 'package:flutter/material.dart';
import 'package:open_weather_app/models/details_models/details_model.dart';
import 'package:open_weather_app/utils/date_time_util.dart';
import 'package:open_weather_app/utils/wheater_util.dart';
import 'package:open_weather_app/widgets/weather_modal_bottom_sheet.dart';

class TodaysForecastContainer extends StatelessWidget {
  const TodaysForecastContainer({
    super.key,
    required this.item,
  });

  final ListElement item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => weatherModalBottomSheet(context, item),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateTimeUtil.get12HourFormat(item.dtTxt),
              style: const TextStyle(fontSize: 16.0),
            ),
            WeatherUtil.getWeatherIcon(
                item.weather?.first.main ?? MainEnum.DEFAULT),
            Text(
              WeatherUtil.getTemperature(item.main?.temp),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
