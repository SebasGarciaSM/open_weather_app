// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  LocationModel({
    this.name,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
