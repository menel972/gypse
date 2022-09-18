import 'package:flutter/cupertino.dart';
import 'package:gypse/core/router.dart';

void main() {
  /// Start app
  runApp(const MyApp());
}

/// Creates the app using the [CupertinoApp.router] constructor and [GoRouter] to navigate
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// The root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
