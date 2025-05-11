part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded({
    required this.todaysForecast,
    required this.currentWeather,
    required this.forecast,
  });

  final WeatherModel currentWeather;
  final List<WeatherModel> todaysForecast;
  final List<WeatherModel> forecast;
}

final class WeatherFailed extends WeatherState {}
