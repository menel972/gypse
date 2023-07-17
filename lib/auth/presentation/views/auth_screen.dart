import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/views/states/auth_views_bloc.dart';
import 'package:gypse/auth/presentation/views/states/forgotten_password_bloc.dart';
import 'package:gypse/auth/presentation/views/states/sign_in_bloc.dart';
import 'package:gypse/auth/presentation/views/states/sign_up_bloc.dart';
import 'package:gypse/auth/presentation/views/widgets/forgotten_password_view.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_in_view.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_up_view.dart';
import 'package:gypse/common/style/colors.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthScreen extends StatelessWidget {
  final Future<String> Function(WidgetRef, UiAuthRequest) signUpUseCase;
  final Future<String> Function(WidgetRef, UiAuthRequest) signInUseCase;
  final Future<bool?> Function(WidgetRef, String) forgottenPasswordUseCase;

  const AuthScreen({
    super.key,
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.forgottenPasswordUseCase,
  });

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return BlocConsumer<AuthViewsBloc, int>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                height: Dimensions.screen(context).height,
                width: Dimensions.screen(context).width,
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: GypseColors.cardGradient,
                    stops: [0, 0.39, 0.6, 0.9],
                    center: Alignment(1, 0.2),
                    startAngle: -0.8,
                    endAngle: 6.5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.s(context).width,
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
                            BlocProvider(
                              create: (_) => SignUpBloc(),
                              child: SignUpView(signUpUseCase),
                            ),
                            BlocProvider(
                              create: (_) => SignInBloc(),
                              child: SignInView(
                                context.read<AuthViewsBloc>().onViewChanged,
                                signInUseCase: signInUseCase,
                              ),
                            ),
                            BlocProvider(
                              create: (_) => ForgottenPasswordBloc(),
                              child: ForgottenPasswordView(
                                context.read<AuthViewsBloc>().onViewChanged,
                                forgottenPasswordUseCase:
                                    forgottenPasswordUseCase,
                              ),
                            ),
                          ][state]),
                      Column(
                        children: [
                          Dimensions.xxs(context).spaceH(),
                          [
                            InkWell(
                              onTap: () => context
                                  .read<AuthViewsBloc>()
                                  .onViewChanged(1),
                              child: RichText(
                                text: TextSpan(
                                  text: words(context).txt_yes_account,
                                  style: GypseFont.xs(),
                                  children: [
                                    TextSpan(text: ' '),
                                    TextSpan(
                                        text: words(context).txt_signin,
                                        style: GypseFont.s(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary))
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => context
                                  .read<AuthViewsBloc>()
                                  .onViewChanged(0),
                              child: RichText(
                                text: TextSpan(
                                  text: words(context).txt_no_account,
                                  style: GypseFont.xs(),
                                  children: [
                                    TextSpan(text: ' '),
                                    TextSpan(
                                        text: words(context).txt_signup,
                                        style: GypseFont.s(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(),
                          ][state]
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
