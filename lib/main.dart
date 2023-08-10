import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/theme.dart';
import 'package:gypse/common/utils/gypse_router.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/is_answered_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Preserves the splash on screen until the method [FlutterNativeSplash.remove()] is invoked
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Initialize Firebase from [firebase_core.dart] with the configuration of [firebase_options.dart]
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// Start app
  runApp(const riverpod.ProviderScope(child: MyApp()));
}

/// Creates the app using the [CupertinoApp.router] constructor and [GoRouter] to navigate
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      debugPrint('ICI: INACTIVE');
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint('ICI: RESUMED');
    }
  }

  /// The root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CurrentUser()),
        ChangeNotifierProvider.value(value: IsAnsweredMenu()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        routeInformationParser: gypseRouter.routeInformationParser,
        routeInformationProvider: gypseRouter.routeInformationProvider,
        routerDelegate: gypseRouter.routerDelegate,
        theme: gypseTheme,
      ),
    );
  }
}
