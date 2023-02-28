class FutureWeather {
  City? city;
  int? cnt;
  List<Information>? information;
  FutureWeather({
    this.city,
    this.cnt,
    this.information,
  });

  FutureWeather.fromJson(Map<String, dynamic> json) {
    city = json["city"] != null ? City.fromJson(json['city']) : null;
    cnt = json["cnt"];
    if (json["list"] != null) {
      information = <Information>[];
      json["list"].forEach((v) {
        information!.add(Information.fromJson(v));
      });
    }
  }
}

class City {
  int? id;
  String? name;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.sunrise,
    this.sunset,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Information {
  double? temp;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  double? windSpeed;
  String? dtTxt;
  List<WeatherInfo>? weatherInfo;

  Information({
    this.temp,
    this.tempMax,
    this.tempMin,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.weatherInfo,
    this.dtTxt,
  });

  Information.fromJson(Map<String, dynamic> json) {
    temp = json["main"]["temp"];
    tempMax = json["main"]["temp_max"];
    tempMin = json["main"]["temp_min"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    windSpeed = json['wind']["speed"];
    dtTxt = json["dt_txt"];
    if (json["weather"] != null) {
      weatherInfo = <WeatherInfo>[];
      json['weather'].forEach((v) {
        weatherInfo!.add(WeatherInfo.fromJson(v));
      });
    }
  }
}

class WeatherInfo {
  String? description;
  String? icon;

  WeatherInfo({
    this.description,
    this.icon,
  });

  WeatherInfo.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    icon = json["icon"];
  }
}
