import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/home/cubit/permission/permission_cubit.dart';

class PermissionWidget extends StatelessWidget {
  const PermissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PermissionCubit, PermissionState>(
      builder: (context, state) {
        final bool isPermanentlyDenied = state is PermissionPermanentlyDenied;

        return Card(
          elevation: 0,
          color: colorScheme.errorContainer.withValues(alpha: 0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(
                  Icons.location_disabled,
                  size: 48,
                  color: colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  isPermanentlyDenied
                      ? 'Location Permission Required'
                      : 'Weather App Needs Your Location',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onErrorContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  isPermanentlyDenied
                      ? 'Please enable location access in your device settings to see weather for your current location.'
                      : 'Allow location access to get accurate weather information for your current area.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton.tonalIcon(
                  onPressed: () {
                    if (isPermanentlyDenied) {
                      context.read<PermissionCubit>().openAppSettings();
                      return;
                    }
                    context.read<PermissionCubit>().requestPermission();
                  },
                  icon: Icon(
                    isPermanentlyDenied ? Icons.settings : Icons.location_on,
                  ),
                  label: Text(
                    isPermanentlyDenied
                        ? 'Open Settings'
                        : 'Allow Location Access',
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
