class Weather {
  Coord? coord;
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  int? pressure;
  List<WeatherModel>? weather;

  Weather({
    this.coord,
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.pressure,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    coord = json["coord"] != null ? Coord.fromJson(json["coord"]) : null;
    if (json['weather'] != null) {
      weather = <WeatherModel>[];
      json['weather'].forEach((v) {
        weather!.add(WeatherModel.fromJson(v));
      });
    } else {}
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json["lon"];
    lat = json["lat"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["lon"] = this.lon;
    data["lat"] = this.lat;
    return data;
  }
}

class WeatherModel {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}
