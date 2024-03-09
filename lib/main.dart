import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/notifications/local_notification_service.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/style/theme.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_router.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/game/presentation/views/states/game_state_cubit.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  LocalNotificationService().init();

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
      'INACTIVE'.log(tag: 'LIFECYCLE');
    }
    if (state == AppLifecycleState.resumed) {
      'RESUMED'.log(tag: 'LIFECYCLE');
    }
  }

  /// The root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Consumer(
      builder: (context, ref, child) {
        ref.listen(connectivityNotifierProvider, (previous, next) {
          if (next == ConnectivityResult.none) {
            GypseDialog(
              context,
              dismissible: false,
              height: Dimensions.xl(context).height,
              child: NetworkErrorScreen(),
            );
          }
        });
        return MultiBlocProvider(
          providers: [
            BlocProvider<GameStateCubit>(
              create: (_) => GameStateCubit(
                ref.read(userProvider.notifier),
                ref.read(questionsProvider.notifier),
                ref.read(recapSessionStateNotifierProvider.notifier),
              ),
            ),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationParser: gypseRouter.routeInformationParser,
            routeInformationProvider: gypseRouter.routeInformationProvider,
            routerDelegate: gypseRouter.routerDelegate,
            theme: gypseTheme,
          ),
        );
      },
    );
  }
}
