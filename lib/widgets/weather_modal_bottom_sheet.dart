import 'package:flutter/material.dart';
import 'package:open_weather_app/models/details_models/details_model.dart';
import 'package:open_weather_app/utils/date_time_util.dart';
import 'package:open_weather_app/utils/wheater_util.dart';
import 'package:open_weather_app/widgets/next_hours_weather_container.dart';

void weatherModalBottomSheet(
  BuildContext context,
  ListElement item,
) {
  showModalBottomSheet(
    elevation: 10.0,
    enableDrag: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(50.0),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 30.0,
                ),
                child: Column(
                  children: [
                    Text(
                      DateTimeUtil.getDayNameAnd12Hour(item.dtTxt),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherUtil.getWeatherIcon(
                            item.weather?.first.main ?? MainEnum.DEFAULT,
                            size: 80.0),
                        const SizedBox(width: 10.0),
                        Text(
                          WeatherUtil.getTemperature(item.main?.temp),
                          style: const TextStyle(
                            fontSize: 100.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item.weather?.first.description?.toUpperCase() ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NextHoursWeatherContainer(
                            header: 'Min',
                            subheader:
                                WeatherUtil.getTemperature(item.main?.tempMin),
                            headerSize: 16.0,
                            subheaderSize: 20.0,
                          ),
                          Container(
                            height: 5.0,
                            width: 50.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                            subheader:
                                WeatherUtil.getTemperature(item.main?.tempMax),
                            headerSize: 16.0,
                            subheaderSize: 20.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 15.0,
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Feels like: ",
                              ),
                              Text(
                                WeatherUtil.getTemperature(
                                    item.main?.feelsLike),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Humidity: ",
                              ),
                              Text(
                                "${item.main?.humidity}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Cloudiness: ",
                              ),
                              Text(
                                "${item.clouds?.all}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Wind speed: ",
                              ),
                              Text(
                                "${item.wind?.speed?.round()}m/s",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Pressure: ",
                              ),
                              Text(
                                "${item.main?.pressure}hPa",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
