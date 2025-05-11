import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home/data/weather_model.dart';
import 'package:weather_app/home/widgets/utils.dart';

class DailyForecaset extends StatelessWidget {
  const DailyForecaset({super.key, required this.dailyForecast});
  final List<WeatherModel> dailyForecast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('5-Day Forecast', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            ...dailyForecast.map((forecast) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        DateFormat('E').format(forecast.dtTxt),
                        style: textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        getWeatherIcon(forecast.weather.first.main),
                        color: colorScheme.primary,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${(forecast.main.tempMin - 273.15).round()}°',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${(forecast.main.tempMax - 273.15).round()}°',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
