// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_auth_request.dart';
import 'package:gypse/auth/presentation/views/widgets/sign_in/states/sign_in_state.dart';
import 'package:gypse/auth/presentation/views/widgets/states/credentials_state.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteAccountDialog extends HookConsumerWidget {
  late String? uId;
  late CredentialsState credentials;

  DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    uId = ref.watch(userProvider)?.uId;
    credentials = ref.watch(signInCredentialsStateNotifierProvider);

    signInUseCase(UiAuthRequest request) =>
        ref.read(signInUseCaseProvider).invoke(request);
    Future<bool> deleteAccountUseCase() =>
        ref.read(deleteAccountUseCaseProvider).invoke();
    Future<void> onDeleteUserUseCase() =>
        ref.read(onDeleteUserUseCaseProvider).invoke(context, uId!);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SUPPRESSION DU COMPTE',
            style: GypseFont.l(
              bold: true,
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Dimensions.xs(context).spaceH(),
          Text(
            'Confirme ton mot de passe pour supprimer ton compte GYPSE.',
            style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          Dimensions.xs(context).spaceH(),
          // NOTE : PASSWORD
          Material(
            color: Colors.transparent,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle:
                    GypseFont.s(color: Theme.of(context).colorScheme.primary),
                suffixIcon: IconButton(
                  onPressed: () => ref
                      .read(signInCredentialsStateNotifierProvider.notifier)
                      .onPasswordVisibilityChanged(),
                  icon: credentials.isPasswordHidden
                      ? SvgPicture.asset(
                          GypseIcon.eye.path,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(
                          GypseIcon.eyeOff.path,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obscureText: credentials.isPasswordHidden,
              onChanged: (value) => ref
                  .read(signInCredentialsStateNotifierProvider.notifier)
                  .onPasswordChanged(value),
            ),
          ),
          Visibility(
            visible: !credentials.passwordError.isNull ||
                credentials.passwordError != '',
            child: Text(
              credentials.passwordError ?? '',
              style: GypseFont.xs(color: Theme.of(context).colorScheme.error),
              maxLines: 1,
            ),
          ),
          Dimensions.xs(context).spaceH(),
          Row(
            children: [
              Expanded(
                child: GypseElevatedButton(
                  context,
                  label: 'Supprimer',
                  onPressed: () async {
                    if (credentials.passwordError.isNullOrEmpty &&
                        credentials.password != '') {
                      String? user = await signInUseCase(UiAuthRequest(
                        ref.read(getUserEmailUseCaseProvider).invoke(),
                        credentials.password,
                      ));

                      if (user.isNullOrEmpty) {
                        'Mot de passe incorrect'.failure(context);
                        return;
                      }

                      ref
                          .read(logActionUseCaseProvider)
                          .invoke(cta: 'delete account');
                      bool result = await deleteAccountUseCase();

                      if (result) {
                        await onDeleteUserUseCase().whenComplete(
                            () => context.go(Screen.authView.path));
                      } else {
                        'Une erreur est survenue'.failure(context);
                      }
                    } else {
                      'Veuillez renseigner un mot de passe valide'
                          .failure(context);
                      return;
                    }
                  },
                  textColor: Theme.of(context).colorScheme.onError,
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
              Dimensions.xxs(context).spaceW(),
              Expanded(
                child: GypseElevatedButton(
                  context,
                  label: 'Annuler',
                  onPressed: () => Navigator.pop(context),
                  textColor: Theme.of(context).colorScheme.primary,
                  backgroundColor:
                      Theme.of(context).colorScheme.surface.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
