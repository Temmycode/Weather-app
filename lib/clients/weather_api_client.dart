import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeahterApiClient {
  final String apiKey = "1b647a93cd55abee850aaf081814fb0f";
  Future<Weather>? getData() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=7.145244&lon=3.327695&exclude={part}&appid=$apiKey&units=metric";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    print(Weather.fromJson(data).weather!.toList()[0].description);
    return Weather.fromJson(data);
  }
}
