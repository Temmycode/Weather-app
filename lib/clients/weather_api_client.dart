import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/provider/current_location_provider.dart';

import '../models/future_weather_model.dart';

class WeahterApiClient {
  final String apiKey = "1b647a93cd55abee850aaf081814fb0f";
  Future<Weather?>? getData() async {
    Weather? result;
    try {
      Position _position = await getCurrentPosition();
      double latitude = _position.latitude;
      double longitude = _position.longitude;

      String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude={part}&appid=$apiKey&units=metric";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        result = Weather.fromJson(data);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<FutureWeather?>? get5DayData() async {
    FutureWeather? result;
    try {
      Position _position = await getCurrentPosition();
      double latitude = _position.latitude;
      double longitude = _position.longitude;
      String url =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&cnt=80";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        result = FutureWeather.fromJson(data);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
