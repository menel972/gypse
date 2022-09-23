import 'package:flutter/material.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/errors/network_error_screen.dart';
import 'package:gypse/core/errors/route_error_screen.dart';

class ErrorsScreen extends StatelessWidget {
  final ErrorCode code;
  final Exception? error;
  final String? message;

  const ErrorsScreen(this.code, {Key? key, this.error, this.message})
      : super(key: key);

  Widget errorCodeRedirect() {
    switch (code) {
      case ErrorCode.network:
        return const NetworkErrorScreen();
      default:
        return RouteErrorScreen(error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return errorCodeRedirect();
  }
}
