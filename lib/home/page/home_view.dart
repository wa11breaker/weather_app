import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/home/cubit/locatoin/location_cubit.dart';
import 'package:weather_app/home/cubit/permission/permission_cubit.dart';
import 'package:weather_app/home/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/home/data/weather_model.dart';
import 'package:weather_app/home/widgets/current_weather.dart';
import 'package:weather_app/home/widgets/daily_forecaset.dart';
import 'package:weather_app/home/widgets/hourly_forecast.dart';
import 'package:weather_app/home/widgets/location_widget.dart';
import 'package:weather_app/home/widgets/permission_widget.dart';
import 'package:weather_app/home/widgets/weather_details.dart';
import 'package:weather_app/home/widgets/weather_error_widget.dart';
import 'package:weather_app/home/widgets/weather_loading_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionState = context.watch<PermissionCubit>().state;
    final locaionState = context.watch<LocationCubit>().state;
    final weatherState = context.watch<WeatherCubit>().state;

    ListElement? weather;

    if (weatherState is WeatherLoaded) {
      weather = weatherState.currentWeather;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //* Permission
          if (permissionState is! PermissionGranted)
            SliverToBoxAdapter(child: PermissionWidget()),

          //* Location loading
          if (locaionState is LocationLoading)
            SliverToBoxAdapter(child: LocationWidget()),

          //* Api loading
          if (weatherState is WeatherLoading)
            SliverToBoxAdapter(child: WeatherLoadingWidget()),

          //* Api failed
          if (weatherState is WeatherFailed)
            SliverToBoxAdapter(
              child: WeatherErrorWidget(
                onRetry: () {
                  final loc = locaionState as LocationLoaded;
                  context.read<WeatherCubit>().fetchWeather(
                    latitude: loc.location.latitude!,
                    longitude: loc.location.longitude!,
                  );
                },
              ),
            ),

          if (weatherState is WeatherLoaded && weather != null) ...[
            // AppBar
            SliverAppBar.large(
              floating: false,
              pinned: true,
              title: Text(
                locaionState is LocationLoaded
                    ? locaionState.cityName ?? 'No location'
                    : "Loading...",
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<LocationCubit>().getLocation();
                  },
                ),
              ],
            ),

            SliverToBoxAdapter(child: CurrentWeather(weather: weather)),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),

            SliverToBoxAdapter(
              child: HourlyForecast(forecasts: weatherState.todaysForecast),
            ),
            SliverToBoxAdapter(
              child: DailyForecaset(dailyForecast: weatherState.forecast),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),

            SliverToBoxAdapter(child: WeatherDetailsWidget(weather: weather)),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
          ],

          SliverToBoxAdapter(child: SafeArea(top: false, child: SizedBox())),
        ],
      ),
    );
  }
}
