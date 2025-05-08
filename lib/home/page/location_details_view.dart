import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/home/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/home/widgets/info_tile.dart';

class LocationDetailView extends StatelessWidget {
  const LocationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            final current =
                state is WeatherLoaded ? state.currentWeather : null;

            if (current == null) {
              return Text('- -');
            }

            final temperature = current.main.temp - 273.15;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  Text(
                    '${temperature.round()}°',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InfoTile(
                        icon: Icons.speed_outlined,
                        value: '${current.wind.speed} m/s',
                        label: 'Wind',
                      ),
                      InfoTile(
                        icon: Icons.water_drop_outlined,
                        value: '${current.main.humidity}',
                        label: 'Humidity',
                      ),
                      InfoTile(
                        icon: Icons.remove_red_eye_outlined,
                        value: '${current.visibility / 1000} km',
                        label: 'Visibility',
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Expanded(
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              final forecast = state is WeatherLoaded ? state.forecast : null;

              if (forecast == null) {
                return SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Forecast',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: forecast.length,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                      separatorBuilder: (_, _) => SizedBox(height: 8),
                      itemBuilder: (BuildContext context, int index) {
                        final temp = forecast[index].main.temp - 273.15;
                        final timeDt = forecast[index].dt;
                        final time = DateTime.fromMillisecondsSinceEpoch(
                          timeDt * 1000,
                        );

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100,
                          ),

                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('EEE, hh:mm a').format(time),
                                style: TextStyle(fontSize: 16),
                              ),

                              Spacer(),
                              Icon(
                                Icons.thermostat_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${temp.round()}°',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
