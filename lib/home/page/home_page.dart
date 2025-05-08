import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/home/cubit/locatoin/location_cubit.dart';
import 'package:weather_app/home/cubit/permission/permission_cubit.dart';
import 'package:weather_app/home/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/home/page/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPermissionStatus();
    });
  }

  void getPermissionStatus() {
    context.read<PermissionCubit>().checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    // final location = context.watch<LocationCubit>().state;
    // final permission = context.watch<PermissionCubit>().state;

    // final hasPermission = permission is PermissionGranted;
    // final isLoading = location is LocationLoading;

    return MultiBlocListener(
      listeners: [
        BlocListener<PermissionCubit, PermissionState>(
          listener: (context, state) {
            if (state is PermissionGranted) {
              context.read<LocationCubit>().getLocation();
            }
          },
        ),
        BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              context.read<WeatherCubit>().fetchWeather(
                latitude: state.location.latitude!,
                longitude: state.location.longitude!,
              );
            }
          },
        ),
      ],
      child: HomeView(),
    );
  }
}
