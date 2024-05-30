// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'package:open_weather_app/globals.dart' as globals;
import 'package:open_weather_app/models/location_model.dart';

class LocationRepository {
  final String locationBaseUrl = "http://api.openweathermap.org/geo/1.0/direct";

  Future<dynamic> getLocationData(String query) async {
    try {
      var url = Uri.parse(
          "$locationBaseUrl?q=$query&limit=0&appid=${globals.apiKey}");

      final response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode == 200) {
        return locationModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
