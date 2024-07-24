import 'dart:convert';

import 'package:weather_app/data/conditions.dart';
import 'package:weather_app/data/weather.dart';

List<dynamic> fromJson(String? json) {
  var jsonObject = jsonDecode(json.toString());

  var hourWeatherList = jsonObject["forecast"]["forecastday"][0]["hour"];
  var forecastDayList = jsonObject["forecast"]["forecastday"];

  List<HourWeather> hourlyWeather = hourWeatherList.map<HourWeather>((hour) => HourWeather.fromJson(hour)).toList();
  List<ForecastDay> forecast = forecastDayList.map<ForecastDay>((day) => ForecastDay.fromJson(day)).toList();

  Location location = Location.fromJson(jsonObject["location"]);
  Condition condition = Condition.fromJson(jsonObject["forecast"]["forecastday"][0]["day"]["condition"]);
  Day day = Day.fromJson(jsonObject["forecast"]["forecastday"][0]["day"]);

  List<dynamic> data = [hourlyWeather, location, condition, day, forecast];
  return data;
}