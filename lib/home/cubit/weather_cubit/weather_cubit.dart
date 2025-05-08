import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/home/data/weather_model.dart';
import 'package:weather_app/home/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required WeatherRepository repository})
    : _repository = repository,
      super(WeatherInitial());

  final WeatherRepository _repository;

  Future<void> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    emit(WeatherLoading());
    try {
      final res = await _repository.getWeather(
        latitude: latitude,
        longitude: longitude,
      );

      final todaysForecast =
          res.where((e) => e.dtTxt.day == DateTime.now().day).toList();

      emit(
        WeatherLoaded(
          currentWeather: res.first,
          todaysForecast: todaysForecast,
          forecast: _getDailyForecast(res),
        ),
      );
    } catch (e) {
      emit(WeatherFailed());
    }
  }

  List<ListElement> _getDailyForecast(List<ListElement> data) {
    final dailyForecast = <ListElement>[];
    final groupedByDate = <String, ListElement>{};
    for (var forecast in data) {
      final dateKey =
          DateTime(
            forecast.dtTxt.year,
            forecast.dtTxt.month,
            forecast.dtTxt.day,
          ).toIso8601String();
      groupedByDate[dateKey] ??= forecast;
    }

    dailyForecast.addAll(groupedByDate.values);
    return dailyForecast;
  }
}
