import 'package:weather_app/data/conditions.dart';

class Astro {
  final String sunrise;
  final String sunset;

  Astro({
    required this.sunrise,
    required this.sunset,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );
}

class Day {
  final double maxtempC;
  final double mintempC;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.condition
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"]?.toDouble(),
        mintempC: json["mintemp_c"]?.toDouble(),
        condition: Condition.fromJson(json["condition"])
      );
}

class HourWeather {
  final String time;
  final double tempC;
  final int isDay;
  final Condition condition;
  final double windMph;
  final String windDir;
  final double pressureMb;
  final double precipMm;
  final int humidity;
  final double feelslikeC;
  final double windchillC;
  final double dewpointC;
  final double uv;

  HourWeather({
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windDir,
    required this.pressureMb,
    required this.precipMm,
    required this.humidity,
    required this.feelslikeC,
    required this.windchillC,
    required this.dewpointC,
    required this.uv,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) => HourWeather(
      time: json["time"],
      tempC: json["temp_c"]?.toDouble(),
      isDay: json["is_day"],
      condition: Condition.fromJson(json["condition"]),
      windMph: json["wind_mph"]?.toDouble(),
      windDir: json["wind_dir"],
      pressureMb: json["pressure_mb"],
      precipMm: json["precip_mm"]?.toDouble(),
      humidity: json["humidity"],
      feelslikeC: json["feelslike_c"]?.toDouble(),
      windchillC: json["windchill_c"]?.toDouble(),
      dewpointC: json["dewpoint_c"]?.toDouble(),
      uv: json["uv"]?.toDouble());
}

class ForecastDay {
  final DateTime date;
  final Day day;
  final Astro astro;
  final List<HourWeather> hourWeather;

  ForecastDay({
    required this.date,
    required this.day,
    required this.astro,
    required this.hourWeather,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => ForecastDay(
    date: DateTime.parse(json["date"]),
    day: Day.fromJson(json["day"]),
    astro: Astro.fromJson(json["astro"]),
    hourWeather: List<HourWeather>.from(json["hour"].map((x) => HourWeather.fromJson(x)))
  ); 
}

class Location {
  final String region;
  final String country;

  Location({
    required this.region,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        region: json["region"],
        country: json["country"],
      );
}
