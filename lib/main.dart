import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/core/themes/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Preserves the splash on screen until the method [FlutterNativeSplash.remove()] is invoked
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Start app
  runApp(const MyApp());
  await Future.delayed(const Duration(seconds: 1));

  /// Remove the splash screen
  FlutterNativeSplash.remove();
}

/// Creates the app using the [CupertinoApp.router] constructor and [GoRouter] to navigate
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// The root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      theme: theme,
    );
  }
}
