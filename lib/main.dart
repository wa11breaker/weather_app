import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:weather_app/home/cubit/locatoin/location_client.dart';
import 'package:weather_app/home/cubit/locatoin/location_cubit.dart';
import 'package:weather_app/home/cubit/permission/permission_cubit.dart';
import 'package:weather_app/home/cubit/permission_client.dart';
import 'package:weather_app/home/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/home/page/home_page.dart';
import 'package:weather_app/home/repository/weather_repository.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LocationClient()),
        RepositoryProvider(create: (context) => PermissionClient()),
        RepositoryProvider(create: (context) => WeatherRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => PermissionCubit(
                  permissionClient: context.read<PermissionClient>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => LocationCubit(
                  locationClient: context.read<LocationClient>(),
                ),
          ),
          BlocProvider(
            create:
                (context) =>
                    WeatherCubit(repository: context.read<WeatherRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: ThemeMode.system,
          home: const HomePage(),
        ),
      ),
    );
  }
}

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({super.key});

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   // Mock data for demonstration
//   final String city = "New York";
//   final String condition = "Partly Cloudy";
//   final double temperature = 22.5;
//   final double feelsLike = 24.0;
//   final int humidity = 68;
//   final double windSpeed = 5.4;

//   final List<Map<String, dynamic>> hourlyForecast = [
//     {
//       "time": DateTime.now().add(const Duration(hours: 1)),
//       "temp": 22.0,
//       "icon": Icons.cloud,
//     },
//     {
//       "time": DateTime.now().add(const Duration(hours: 2)),
//       "temp": 21.5,
//       "icon": Icons.cloud,
//     },
//     {
//       "time": DateTime.now().add(const Duration(hours: 3)),
//       "temp": 21.0,
//       "icon": Icons.wb_cloudy,
//     },
//     {
//       "time": DateTime.now().add(const Duration(hours: 4)),
//       "temp": 20.0,
//       "icon": Icons.wb_cloudy,
//     },
//     {
//       "time": DateTime.now().add(const Duration(hours: 5)),
//       "temp": 19.5,
//       "icon": Icons.wb_cloudy,
//     },
//     {
//       "time": DateTime.now().add(const Duration(hours: 6)),
//       "temp": 19.0,
//       "icon": Icons.nights_stay,
//     },
//   ];

//   final List<Map<String, dynamic>> dailyForecast = [
//     {"day": "Today", "high": 23.0, "low": 18.0, "icon": Icons.cloud},
//     {"day": "Tomorrow", "high": 25.0, "low": 19.0, "icon": Icons.wb_sunny},
//     {"day": "Saturday", "high": 27.0, "low": 20.0, "icon": Icons.wb_sunny},
//     {"day": "Sunday", "high": 24.0, "low": 19.0, "icon": Icons.wb_cloudy},
//     {"day": "Monday", "high": 22.0, "low": 18.0, "icon": Icons.thunderstorm},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar.large(
//             floating: false,
//             pinned: true,
//             title: Text(city),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.refresh),
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Refreshing weather data...")),
//                   );
//                 },
//               ),
//               IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
//             ],
//           ),
//           SliverToBoxAdapter(child: _buildCurrentWeather(colorScheme)),
//           SliverToBoxAdapter(child: _buildHourlyForecast(colorScheme)),
//           SliverToBoxAdapter(child: _buildDailyForecast(colorScheme)),
//           SliverToBoxAdapter(child: _buildWeatherDetails(colorScheme)),
//           SliverToBoxAdapter(child: const SizedBox(height: 20)),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) => _buildLocationSearch(),
//           );
//         },
//         child: const Icon(Icons.location_on),
//       ),
//     );
//   }

//   Widget _buildCurrentWeather(ColorScheme colorScheme) {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '$temperature°C',
//                         style: Theme.of(context).textTheme.displayLarge,
//                       ),
//                       Text(
//                         'Feels like $feelsLike°C',
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         condition,
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         DateFormat('EEEE, d MMMM y').format(DateTime.now()),
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.cloud, size: 80),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHourlyForecast(ColorScheme colorScheme) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hourly Forecast',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: 120,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: hourlyForecast.length,
//                 itemBuilder: (context, index) {
//                   final forecast = hourlyForecast[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 16),
//                     child: Column(
//                       children: [
//                         Text(
//                           DateFormat('h a').format(forecast["time"]),
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                         const SizedBox(height: 8),
//                         Icon(
//                           forecast["icon"],
//                           size: 32,
//                           color: colorScheme.primary,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '${forecast["temp"]}°C',
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDailyForecast(ColorScheme colorScheme) {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '5-Day Forecast',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             ...dailyForecast.map((forecast) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         forecast["day"],
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Icon(forecast["icon"], color: colorScheme.primary),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             '${forecast["low"]}°',
//                             style: TextStyle(
//                               color: colorScheme.onSurfaceVariant,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             '${forecast["high"]}°',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWeatherDetails(ColorScheme colorScheme) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Weather Details',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildDetailItem(
//                     Icons.water_drop,
//                     'Humidity',
//                     '$humidity%',
//                     colorScheme,
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildDetailItem(
//                     Icons.air,
//                     'Wind',
//                     '$windSpeed km/h',
//                     colorScheme,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildDetailItem(
//                     Icons.visibility,
//                     'Visibility',
//                     '24 km',
//                     colorScheme,
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildDetailItem(
//                     Icons.compress,
//                     'Pressure',
//                     '1013 hPa',
//                     colorScheme,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailItem(
//     IconData icon,
//     String label,
//     String value,
//     ColorScheme colorScheme,
//   ) {
//     return Column(
//       children: [
//         Icon(icon, color: colorScheme.primary, size: 28),
//         const SizedBox(height: 8),
//         Text(label, style: TextStyle(color: colorScheme.onSurfaceVariant)),
//         const SizedBox(height: 4),
//         Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//       ],
//     );
//   }

//   Widget _buildLocationSearch() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Search Location',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Enter city name',
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           FilledButton.icon(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.location_searching),
//             label: const Text('Search'),
//           ),
//         ],
//       ),
//     );
//   }
// }
