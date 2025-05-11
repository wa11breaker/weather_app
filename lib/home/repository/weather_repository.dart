// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/home/data/weather_model.dart';
import 'package:weather_app/home/repository/http_client.dart';

class WeatherException implements Exception {}

class WeatherRepository {
  WeatherRepository({HttpClient? client}) : _client = client ?? HttpClient();

  final HttpClient _client;
  final baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<List<WeatherModel>> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final key = dotenv.env['OPEN_WEATHER_KEY'];
    final url = '$baseUrl?lat=$latitude&lon=$longitude&appid=$key';

    try {
      final res = await _client.get(url);
      final json = jsonDecode(res.body);

      List<WeatherModel> weatherDatas = [];
      for (final i in json["list"] as List) {
        weatherDatas.add(WeatherModel.fromJson(i));
      }

      return weatherDatas;
    } catch (e) {
      throw WeatherException();
    }
  }
}
