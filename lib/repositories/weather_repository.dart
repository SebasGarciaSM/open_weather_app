// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_weather_app/globals.dart' as globals;
import 'package:open_weather_app/models/details_models/details_model.dart';

class WeatherRepository {
  final String weatherBaseUrl =
      "http://api.openweathermap.org/data/2.5/forecast";

  Future<List<ListElement>> getWeatherDetails(String lat, String lon) async {
    try {
      var url = Uri.parse(
          "$weatherBaseUrl?lat=$lat&lon=$lon&units=metric&appid=${globals.apiKey}");

      final response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body)['list'];
        List<ListElement> results = [];
        print(decodedResponse);
        for (var item in decodedResponse) {
          results.add(ListElement.fromJson(item));
        }
        return results;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
