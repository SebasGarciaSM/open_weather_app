import 'package:flutter/material.dart';
import 'package:open_weather_app/models/details_models/details_model.dart';
import 'package:open_weather_app/utils/date_time_util.dart';
import 'package:open_weather_app/utils/wheater_util.dart';
import 'package:open_weather_app/widgets/next_hours_weather_container.dart';
import 'package:open_weather_app/widgets/weather_modal_bottom_sheet.dart';

class NextHoursForecastListTile extends StatelessWidget {
  const NextHoursForecastListTile({
    super.key,
    required this.item,
  });

  final ListElement item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => weatherModalBottomSheet(context, item),
      title: Row(
        children: [
          Flexible(
            child: Text(
              DateTimeUtil.getDayName(item.dtTxt),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('-'),
          ),
          Flexible(
            child: Text(
              DateTimeUtil.get12HourFormat(item.dtTxt),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      leading: WeatherUtil.getWeatherIcon(
        item.weather?.first.main ?? MainEnum.DEFAULT,
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          NextHoursWeatherContainer(
            header: 'Min',
            subheader: WeatherUtil.getTemperature(item.main?.tempMin),
            headerSize: 12.0,
            subheaderSize: 16.0,
          ),
          Container(
            height: 5.0,
            width: 50.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              gradient: const LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.deepOrange,
                ],
              ),
            ),
          ),
          NextHoursWeatherContainer(
            header: 'Max',
            subheader: WeatherUtil.getTemperature(item.main?.tempMax),
            headerSize: 12.0,
            subheaderSize: 16.0,
          ),
        ],
      ),
    );
  }
}
