import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home/data/weather_model.dart';
import 'package:weather_app/home/widgets/utils.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key, required this.weather});

  final ListElement weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${(weather.main.temp - 273.15).round()}°C',
                        style: textTheme.displayLarge,
                      ),
                      Text(
                        'Feels like ${(weather.main.feelsLike - 273.15).round()}°C',
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        capitalize(weather.weather.firstOrNull?.main.name),
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Icon(
                  getWeatherIcon(
                    weather.weather.firstOrNull?.main ?? MainEnum.CLEAR,
                  ),
                  size: 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String capitalize(String? input) {
    if (input == null || input.isEmpty) return '- -';
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
