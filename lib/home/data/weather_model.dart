class WeatherModel {
  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  DateTime dtTxt;
  Rain? rain;

  WeatherModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
    this.rain,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    dt: json["dt"],
    main: MainClass.fromJson(json["main"]),
    weather: List<Weather>.from(
      json["weather"].map((x) => Weather.fromJson(x)),
    ),
    clouds: Clouds.fromJson(json["clouds"]),
    wind: Wind.fromJson(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"]?.toDouble(),
    dtTxt: DateTime.parse(json["dt_txt"]),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds.toJson(),
    "wind": wind.toJson(),
    "visibility": visibility,
    "pop": pop,
    "dt_txt": dtTxt.toIso8601String(),
    "rain": rain?.toJson(),
  };
}

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) =>
      Clouds(all: json["all"]);

  Map<String, dynamic> toJson() => {"all": all};
}

class MainClass {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Rain {
  double the3H;

  Rain({required this.the3H});

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(the3H: json["3h"]?.toDouble());

  Map<String, dynamic> toJson() => {"3h": the3H};
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  int id;
  MainEnum main;
  Description? description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: mainEnumValues.map[json["main"]]!,
    description: descriptionValues.map[json["description"]],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": mainEnumValues.reverse[main],
    "description": descriptionValues.reverse[description],
    "icon": icon,
  };
}

enum Description {
  BROKEN_CLOUDS,
  CLEAR_SKY,
  FEW_CLOUDS,
  LIGHT_RAIN,
  MODERATE_RAIN,
  OVERCAST_CLOUDS,
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "light rain": Description.LIGHT_RAIN,
  "moderate rain": Description.MODERATE_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS,
});

enum MainEnum {
  CLEAR,
  CLOUDS,
  RAIN,
  THUNDERSTORM,
  DRIZZLE,
  SNOW,
  MIST,
  SMOKE,
  HAZE,
  DUST,
  FOG,
  SAND,
  ASH,
  SQUALL,
  TORNADO,
}

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN,
  "Thunderstorm": MainEnum.THUNDERSTORM,
  "Drizzle": MainEnum.DRIZZLE,
  "Snow": MainEnum.SNOW,
  "Mist": MainEnum.MIST,
  "Smoke": MainEnum.SMOKE,
  "Haze": MainEnum.HAZE,
  "Dust": MainEnum.DUST,
  "Fog": MainEnum.FOG,
  "Sand": MainEnum.SAND,
  "Ash": MainEnum.ASH,
  "Squall": MainEnum.SQUALL,
  "Tornado": MainEnum.TORNADO,
});

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {"speed": speed, "deg": deg, "gust": gust};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
