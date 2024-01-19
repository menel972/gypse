// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/auth/domain/usecase/auth_use_cases.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
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
  DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    uId = ref.watch(userProvider)?.uId;
    Future<bool> deleteAccountUseCase() =>
        ref.read(deleteAccountUseCaseProvider).invoke();
    Future<void> onDeleteUserUseCase() =>
        ref.read(onDeleteUserUseCaseProvider).invoke(context, uId!);

    return Column(
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
          'Es-tu sûr.e de vouloir supprimer ton compte GYPSE.',
          style: GypseFont.m(color: Theme.of(context).colorScheme.primary),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        Dimensions.xs(context).spaceH(),
        Row(
          children: [
            Expanded(
              child: GypseElevatedButton(
                context,
                label: 'Supprimer',
                onPressed: () async {
                  ref
                      .read(logActionUseCaseProvider)
                      .invoke(cta: 'delete account');
                  bool result = await deleteAccountUseCase();

                  if (result) {
                    await onDeleteUserUseCase()
                        .whenComplete(() => context.go(Screen.authView.path));
                  } else {
                    'Une erreur est survenue'.failure(context);
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
    );
  }
}
