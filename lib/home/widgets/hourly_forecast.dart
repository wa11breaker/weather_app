import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home/data/weather_model.dart';
import 'package:weather_app/home/widgets/utils.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key, required this.forecasts});
  final List<ListElement> forecasts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hourly Forecast', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecasts.length,
                itemBuilder: (context, index) {
                  final forecast = forecasts[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('h:mm a').format(forecast.dtTxt),
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          getWeatherIcon(forecast.weather.first.main),
                          size: 32,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(forecast.main.temp - 273.15).round()}°C',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
