import 'package:flutter/material.dart';
import 'package:weather_app/home/data/weather_model.dart' show WeatherModel;

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({super.key, required this.weather});

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.water_drop,
                    'Humidity',
                    '${weather.main.humidity}%',
                    colorScheme,
                  ),
                ),

                Expanded(
                  child: _buildDetailItem(
                    Icons.air,
                    'Wind',
                    '${weather.wind.speed} km/h',
                    colorScheme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.visibility,
                    'Visibility',
                    '${weather.visibility ~/ 1000} km',
                    colorScheme,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.compress,
                    'Pressure',
                    '${weather.main.pressure} hPa',
                    colorScheme,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 28),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
