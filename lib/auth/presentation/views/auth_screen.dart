// ignore_for_file: must_be_immutable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gypse/auth/presentation/views/states/auth_state.dart';
import 'package:gypse/auth/presentation/views/widgets/password/forgotten_password_view.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_in/sign_in_view.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up/sign_up_view.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthScreen extends HookConsumerWidget {
  late int authState;

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next == ConnectivityResult.none) {
        NetworkErrorScreen(context);
      }
    });

    ref.read(logDisplayUseCaseProvider).invoke(screen: Screen.authView.path);

    authState = ref.watch(authStateNotifierProvider);
    FlutterNativeSplash.remove();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: Dimensions.screen(context).height,
          width: Dimensions.screen(context).width,
          decoration: const BoxDecoration(
            gradient: SweepGradient(
              colors: GypseColors.cardGradient,
              stops: [0, 0.39, 0.6, 0.9],
              center: Alignment(1, 0.2),
              startAngle: -0.8,
              endAngle: 6.5,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.xs(context).width,
                  horizontal: Dimensions.xs(context).width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    '$imagesPath/splash_logo.png',
                    width: Dimensions.l(context).width,
                  ),
                  Expanded(
                      flex: 3,
                      child: [
                        SignUpView(),
                        SignInView(),
                        ForgottenPasswordView(),
                      ][authState]),
                  Column(
                    children: [
                      Dimensions.xxs(context).spaceH(),
                      [
                        InkWell(
                          onTap: () => ref
                              .read(authStateNotifierProvider.notifier)
                              .onViewChanged(1),
                          child: RichText(
                            text: TextSpan(
                              text: 'Déjà un compte ?',
                              style: const GypseFont.xs(),
                              children: [
                                const TextSpan(text: ' '),
                                TextSpan(
                                    text: 'Connectez-vous',
                                    style: GypseFont.s(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => ref
                              .read(authStateNotifierProvider.notifier)
                              .onViewChanged(0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Pas encore de compte ?',
                              style: const GypseFont.xs(),
                              children: [
                                const TextSpan(text: ' '),
                                TextSpan(
                                    text: 'Créer un compte',
                                    style: GypseFont.s(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(),
                      ][authState]
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
