// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/connectivity_service.dart';
import 'package:gypse/core/router.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/auth_domain_provider.dart';
import 'package:gypse/domain/providers/init_domain_provider.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/home/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

/// Internet connection check
///
/// Check the internet connection of the device using [ConnectivityCubit] & [ConnectivityState]
/// Redirects the user if he doesn't have an internet connection
class ConnectionChekScreen extends riverpod.HookConsumerWidget {
  const ConnectionChekScreen({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;

    String? uid = ref.read(AuthDomainProvider().getUserUidUsecaseProvider).uid;

    void checkAuthState() => ref
        .read(AuthDomainProvider().checkAuthStateUsecaseProvider)
        .checkAuthState(context);

    Future<void> initApp() async => await ref
        .read(InitDomainProvider().initAppUsecaseProvider)
        .initApp(context);

    Future<void> setCurrentUser() async =>
        Provider.of<CurrentUser>(context, listen: false).setCurrentUser(
            await ref
                .read(UsersDomainProvider().fetchUserUsecaseProvider)
                .fetchUserById(uid));

    checkAuthState();

    return BlocProvider(
      create: (_) => ConnectivityCubit(),
      child: BlocConsumer<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) async {
          // TODO : Decommenter pour activer le check réseau
          // if (state.state == ConnectivityResult.none) {
          //   context.go(ScreenPaths.error, extra: ErrorCode.network);
          // }
          if (user.status == LoginState.authenticated) {
            await initApp();
            setCurrentUser();
            FlutterNativeSplash.remove();
          }
          if (user.status == LoginState.unauthenticated) {
            context.go(ScreenPaths.auth);
            FlutterNativeSplash.remove();
          }
        },
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    );
  }
}
