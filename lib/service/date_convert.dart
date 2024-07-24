import 'package:weather_app/data/weather.dart';

// TODO: Переделать этот говно-код
String convertDate(ForecastDay? forecast) {

  if (forecast == null) return '';
  if (forecast.date.day == DateTime.now().day) return 'Сегодня';

  int weekday = forecast.date.weekday;
  String weekdayString = '';
  int day = forecast.date.day;
  String dayString = day.toString();
  int month = forecast.date.month;
  String monthString = '';

  switch (weekday) {
    case 1:
      weekdayString = 'Понедельник';
      break;
    case 2:
      weekdayString = 'Вторник';
      break;
    case 3:
      weekdayString = 'Среда';
      break;
    case 4:
      weekdayString = 'Четверг';
      break;
    case 5:
      weekdayString = 'Пятница';
      break;
    case 6:
      weekdayString = 'Суббота';
      break;
    case 7:
      weekdayString = 'Воскресенье';
      break;
  }

  switch (month) {
    case 1:
      monthString = 'янв.';
    case 2:
      monthString = 'фев.';
    case 3:
      monthString = 'мар.';
    case 4:
      monthString = 'апр.';
    case 5:
      monthString = 'май';
    case 6:
      monthString = 'июн.';
    case 7:
      monthString = 'июл.';
    case 8:
      monthString = 'авг.';
    case 9:
      monthString = 'сен.';
    case 10:
      monthString = 'окт.';
    case 11:
      monthString = 'ноя.';
    case 12:
      monthString = 'дек.';
  }

  return '$weekdayString, $dayString $monthString';
}
