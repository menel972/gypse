import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/auth/presentation/views/states/auth_credentials_state.dart';
import 'package:gypse/auth/presentation/views/states/forgotten_password_bloc.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgottenPasswordView extends HookConsumerWidget {
  final Function(int) onSelectedView;
  final Future<bool?> Function(WidgetRef, String) forgottenPasswordUseCase;
  const ForgottenPasswordView(this.onSelectedView,
      {required this.forgottenPasswordUseCase, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocConsumer<ForgottenPasswordBloc, AuthCredentialsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Dimensions.s(context).spaceH(),
              Text(
                words(context).title_forget_mdp,
                style: GypseFont.xl(bold: true),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              Dimensions.xxs(context).spaceH(),
              Text(
                words(context).txt_forget_mdp,
                style: GypseFont.m(bold: true),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              Dimensions.xs(context).spaceH(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: words(context).label_mail,
                  suffixIcon: Icons.alternate_email.show(),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<ForgottenPasswordBloc>().onEmailChanged(value),
              ),
              Visibility(
                visible: !state.emailError.isNull || state.emailError != '',
                child: Text(
                  state.emailError ?? '',
                  style:
                      GypseFont.xs(color: Theme.of(context).colorScheme.error),
                  maxLines: 1,
                ),
              ),
              Dimensions.xxs(context).spaceH(),
              Row(
                children: [
                  Expanded(
                    child: GypseElevatedButton(
                      context,
                      onPressed: () async {
                        bool isFormValid = context
                            .read<ForgottenPasswordBloc>()
                            .onFormValidated();

                        if (isFormValid) {
                          await forgottenPasswordUseCase(ref, state.email)
                              .then((bool? result) {
                            if (result == true) {
                              words(context).txt_mail.success(context);
                              return result;
                            }
                          }).catchError((e) {
                            String msg = e.message as String;
                            msg.failure(context);
                            msg.log();
                            return false;
                          });
                        } else {
                          words(context).snack_error_form.failure(context);
                        }
                      },
                      label: words(context).btn_send,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Dimensions.xxs(context).spaceW(),
                  Expanded(
                    child: GypseElevatedButton(
                      context,
                      onPressed: () => onSelectedView(1),
                      label: words(context).btn_annule,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
