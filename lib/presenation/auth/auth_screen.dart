import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/presenation/auth/bloc/sign_in_cubit.dart';
import 'package:gypse/presenation/auth/bloc/sign_up_cubit.dart';
import 'package:gypse/presenation/auth/bloc/switch_view_bloc.dart';
import 'package:gypse/core/bloc/bloc_provider.dart' as blocs;
import 'package:gypse/presenation/auth/sign_in/sign_in.dart';
import 'package:gypse/presenation/auth/sign_up/sign_up.dart';

/// Login view
///
/// AuthScreen allows users to sign in and sign up
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = blocs.BlocProvider.of<SwitchViewBloc>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            colors: Couleur.cardGradientColors,
            stops: [0, 0.39, 0.6, 0.9],
            center: Alignment(1, 0.2),
            startAngle: -0.8,
            endAngle: 6.5,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize(context).width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    width: screenSize(context).width * 0.25,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<int>(
                    stream: bloc.stream,
                    builder: (context, snapshot) => [
                      BlocProvider(
                          create: (_) => SignUpCubit(),
                          child: SignUp(bloc.switchView)),
                      BlocProvider(
                          create: (_) => SignInCubit(),
                          child: SignIn(bloc.switchView)),
                    ][snapshot.data!],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
