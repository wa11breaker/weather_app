import 'package:flutter/material.dart';
import 'package:weather_app/home/data/weather_model.dart';

IconData getWeatherIcon(MainEnum condition, {bool isDay = true}) {
  switch (condition) {
    case MainEnum.CLEAR:
      return isDay ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded;

    case MainEnum.CLOUDS:
      return isDay ? Icons.cloud_rounded : Icons.cloud_rounded;

    case MainEnum.RAIN:
      return Icons.grain_rounded;

    case MainEnum.THUNDERSTORM:
      return Icons.flash_on_rounded;

    case MainEnum.DRIZZLE:
      return Icons.water_drop_rounded;

    case MainEnum.SNOW:
      return Icons.ac_unit_rounded;

    case MainEnum.MIST:
    case MainEnum.FOG:
    case MainEnum.HAZE:
      return Icons.cloud_rounded;

    case MainEnum.SMOKE:
    case MainEnum.DUST:
    case MainEnum.SAND:
    case MainEnum.ASH:
      return Icons.blur_on_rounded;

    case MainEnum.SQUALL:
      return Icons.air_rounded;

    case MainEnum.TORNADO:
      return Icons.tornado_rounded;
  }
}
