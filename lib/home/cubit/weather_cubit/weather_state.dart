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

  final ListElement currentWeather;
  final List<ListElement> todaysForecast;
  final List<ListElement> forecast;
}

final class WeatherFailed extends WeatherState {}
