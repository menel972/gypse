// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/input_themes.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/providers/auth_domain_provider.dart';
import 'package:gypse/presenation/auth/bloc/credentials_state.dart';
import 'package:gypse/presenation/auth/bloc/forgotten_password_cubit.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;

class ForgottenPasswordDialog extends riverpod.HookConsumerWidget {
  final Function(int) switchView;
  const ForgottenPasswordDialog(this.switchView, {super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    Future<void> forgottenPassword(String email) async => await ref
        .read(AuthDomainProvider().forgottenPasswordProvider)
        .forgottenPassword(email);

    return BlocConsumer<ForgottenPasswordCubit, CredentialsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AutoSizeText(
                  // TODO : UTILISER UNE CLÉ DE TRAD
                  'MOT DE PASSE OUBLIÉ ?',
                  style: TextXL(Couleur.text, isBold: true),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: screenSize(context).height * 0.03),
                const AutoSizeText(
                  'Réinitialisez votre passe',
                  style: TextM(Couleur.text),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: screenSize(context).height * 0.04),
                TextFormField(
                  decoration: inputDecoration(
                      words(context).label_mail,
                      const Icon(
                        Icons.alternate_email,
                        color: Couleur.text,
                      )),
                  style: const TextM(Couleur.text),
                  onChanged: (value) => context
                      .read<ForgottenPasswordCubit>()
                      .onEmailChanged(value),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                ),
                Visibility(
                  visible: state.emailError != null || state.emailError != '',
                  child: AutoSizeText(
                    state.emailError ?? '',
                    style: const TextXS(Couleur.error),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: screenSize(context).height * 0.04),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        context,
                        // TODO : Clé de trad
                        text: 'Envoyer',
                        textColor: Couleur.text,
                        color: Couleur.secondary,
                        onPressed: () async {
                          if (context
                              .read<ForgottenPasswordCubit>()
                              .onSignInRequest(context)) {
                            await forgottenPassword(state.email);
                            switchView(1);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: screenSize(context).width * 0.02),
                    Expanded(
                      child: PrimaryButton(
                        context,
                        text: words(context).btn_annule,
                        onPressed: () => switchView(1),
                        textColor: Couleur.text,
                        color: Couleur.primarySurface.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
