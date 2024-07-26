import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:weather_app/data/conditions.dart';
import 'package:weather_app/data/weather.dart';
import 'package:weather_app/presentation/ui/dewpoint_pill.dart';
import 'package:weather_app/service/date_convert.dart';
import 'package:weather_app/service/from_json.dart';
import 'package:weather_app/service/get_user_position.dart';
import 'package:weather_app/service/http_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HourWeather? hour;
  String? jsonRow;

  List<HourWeather>? weather;
  Location? location;
  Condition? condition;
  Day? day;
  List<ForecastDay>? forecast;

  Position? _position;

  @override
  void initState() {
    super.initState();
    convertFromFuture();
  }

  Future<void> convertFromFuture() async {
    Position position = await determinePosition();
    String response =
        await httpRequest(_position?.latitude, _position?.longitude);
    List<dynamic> data = fromJson(response);

    setState(() {
      _position = position;
      jsonRow = response;
      weather = data[0];
      location = data[1];
      condition = data[2];
      day = data[3];
      forecast = data[4];
      hour = weather!.firstWhere((element) =>
          element.time.substring(11, 13) == '${DateTime.now().hour}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${location?.country}, ${location?.region}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: [
            Text(
              'Сейчас',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${weather?[0].tempC.toInt()}°',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Image.network(condition?.icon
                            .replaceAll('//', 'https://') ??
                        'https://cdn0.iconfinder.com/data/icons/shift-free/32/Error-512.png'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${condition?.text}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Ощущается как ${weather?[0].feelslikeC.toInt()}°',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Максимум ${day?.maxtempC.toInt()}° • Минимум ${day?.mintempC.toInt()}°',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              'Почасовой прогноз',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weather?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${weather?[index].tempC.toInt()}°',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Column(
                          children: [
                            Image.network(
                              'http:${weather?[index].condition.icon ?? '//cdn0.iconfinder.com/data/icons/shift-free/32/Error-512.png'}',
                              scale: 2,
                            ),
                            Text(
                              '${weather?[index].time.substring(11)}',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Прогноз погоды на 10 д.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            forecast != null
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: forecast?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: index == 0
                                      ? const Radius.circular(16)
                                      : const Radius.circular(4),
                                  topRight: index == 0
                                      ? const Radius.circular(16)
                                      : const Radius.circular(4),
                                  bottomLeft: index == 2
                                      ? const Radius.circular(16)
                                      : const Radius.circular(4),
                                  bottomRight: index == 2
                                      ? const Radius.circular(16)
                                      : const Radius.circular(4),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(convertDate(forecast?[index]),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Image.network(
                                      'http:${forecast?[index].day.condition.icon}'),
                                  Text(
                                    '${forecast?[index].day.maxtempC.toInt()}°/${forecast?[index].day.mintempC.toInt()}°',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  )
                : const CircularProgressIndicator(),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Погода сейчас',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              crossAxisCount: 2,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Скорость ветра',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${(hour?.windMph ?? 0 * 1.6).toInt()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    Text(
                                      ' км/ч',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                Text(hour?.windDir ?? 'null',
                                    style:
                                        Theme.of(context).textTheme.labelSmall)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Влажность'),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('${hour?.humidity}'),
                                    Text('%')
                                  ],
                                ),
                                Text(
                                  'Точка росы ${hour?.dewpointC.toInt()}°',
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              children: [
                                Text('100',
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: DewpointPillWidget(
                                    humidity: hour?.humidity.toDouble(),
                                  ),
                                ),
                                Text('0',
                                    style:
                                        Theme.of(context).textTheme.labelSmall)
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// TODO: Выделить все конструкции в отдельные переменные