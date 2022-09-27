import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/connectivity_service.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/presenation/home/home_screen.dart';

/// Internet connection check
///
/// Check the internet connection of the device using [ConnectivityCubit] & [ConnectivityState]
/// Redirects the user if he doesn't have an internet connection
class ConnectionChekScreen extends StatelessWidget {
  const ConnectionChekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConnectivityCubit(),
      child: BlocConsumer<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state.state == ConnectivityResult.none) {
            context.go(ScreenPaths.error, extra: ErrorCode.network);
          }
        },
        builder: (context, state) => HomeScreen(),
      ),
    );
  }
}
