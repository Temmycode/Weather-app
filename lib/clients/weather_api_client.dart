import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/provider/current_location_provider.dart';

import '../models/future_weather_model.dart';

class WeahterApiClient {
  final String apiKey = "1b647a93cd55abee850aaf081814fb0f";

  // calculating the cnt value of the application
  int cntValue() {
    DateTime now = DateTime.now();
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    int remainingHours = endOfDay.difference(now).inHours;
    int cnt = remainingHours ~/ 3;
    return cnt;
  }

  // function to get api data for the current positions weather
  Future<Weather?>? getData() async {
    Weather? result;
    try {
      Position position = await getCurrentPosition();
      double latitude = position.latitude;
      double longitude = position.longitude;

      String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude={part}&appid=$apiKey&units=metric";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        result = Weather.fromJson(data);
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  // funciton to get api data for the next five day's weather
  Future<FutureWeather?>? get5DayData() async {
    FutureWeather? result;
    try {
      Position position = await getCurrentPosition();
      double latitude = position.latitude;
      double longitude = position.longitude;
      String url =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&cnt=80";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        result = FutureWeather.fromJson(data);
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  // function to get api data for 3 hours interval of the present time
  Future<FutureWeather?>? get3HoursData() async {
    FutureWeather? result;
    try {
      Position position = await getCurrentPosition();

      double latitude = position.latitude;

      double longitude = position.longitude;

      int cnt = cntValue();

      String url =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&cnt=$cnt";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        log("finally");
        log("10");
        result = FutureWeather.fromJson(data);
        log("11");
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  // function to get the information for the next day interval in time
  Future<FutureWeather?>? getTomorrowData() async {
    FutureWeather? result;
    log("0");
    try {
      Position position = await getCurrentPosition();
      log("1");
      double latitude = position.latitude;
      log("2");
      double longitude = position.longitude;
      log("3");
      String url =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&cnt=8";
      log("4");
      var response = await http.get(Uri.parse(url));
      log("5");
      if (response.statusCode == 200) {
        log("6");
        Map<String, dynamic> data = jsonDecode(response.body);
        log("7");
        log("finally");
        log("9");
        result = FutureWeather.fromJson(data);
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
