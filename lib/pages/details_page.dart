import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_weather_app/models/details_models/details_model.dart';
import 'package:open_weather_app/models/location_model.dart';
import 'package:open_weather_app/repositories/weather_repository.dart';
import 'package:open_weather_app/utils/wheater_util.dart';
import 'package:open_weather_app/widgets/next_hours_forecast_list_tile.dart';
import 'package:open_weather_app/widgets/todays_forecast_container.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.locationModel,
  });

  final LocationModel locationModel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //Weather Repository
  final WeatherRepository _weatherRepository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.locationModel.name ?? ""),
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: FutureBuilder<List<ListElement>>(
        future: _weatherRepository.getWeatherDetails(
          widget.locationModel.lat.toString(),
          widget.locationModel.lon.toString(),
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.none:
              return Container();
            case ConnectionState.active:
              return Container();
            case ConnectionState.done:
              List<ListElement> todaysForecast = [];
              List<ListElement> otherDaysForecast = [];

              for (ListElement item in snapshot.data ?? []) {
                if (WeatherUtil.isToday(item)) {
                  todaysForecast.add(item);
                }
              }

              for (ListElement item in snapshot.data ?? []) {
                if (!WeatherUtil.isToday(item)) {
                  otherDaysForecast.add(item);
                }
              }

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                children: [
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 10.0),
                              Text(
                                "Today's forecast",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        (todaysForecast.isEmpty)
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 25.0),
                                child: const Center(
                                  child: Text('No data available'),
                                ),
                              )
                            : Container(
                                height: 120.0,
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 10.0,
                                ),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: todaysForecast.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10.0);
                                  },
                                  itemBuilder: (context, index) {
                                    var todayItem = todaysForecast[index];
                                    return TodaysForecastContainer(
                                        item: todayItem);
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black12),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.timelapse),
                        SizedBox(width: 10.0),
                        Text(
                          "Next hours forecast",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: otherDaysForecast.length,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1.0);
                    },
                    itemBuilder: (context, index) {
                      var otherDayItem = otherDaysForecast[index];
                      return NextHoursForecastListTile(item: otherDayItem);
                    },
                  )
                ],
              );
            default:
              return const Text('Unhandle State');
          }
        },
      ),
    );
  }
}
