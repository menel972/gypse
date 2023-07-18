// ignore_for_file: must_be_immutable

import 'package:blur/blur.dart';
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
  final BuildContext context;

  late String? uId;
  DeleteAccountDialog(this.context, {super.key}) {
    showDialog(
      context: context,
      builder: (context) => this,
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    uId = ref.watch(userProvider)?.uId;
    Future<bool> deleteAccountUseCase() =>
        ref.read(deleteAccountUseCaseProvider).invoke();
    Future<void> onDeleteUserUseCase() =>
        ref.read(onDeleteUserUseCaseProvider).invoke(context, uId!);

    return Center(
      child: Container(
        height: Dimensions.xl(context).height,
        width: Dimensions.screen(context).width * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).colorScheme.surface),
        ),
        child: Blur(
          blur: 3,
          blurColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          overlay: Padding(
            padding: EdgeInsets.all(Dimensions.xxs(context).height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SUPPRESSION DU PROFILE',
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
                  'Êtes-vous sûr.e de vouloir supprimer votre profile GYPSE. Cette action est définitive.',
                  style:
                      GypseFont.m(color: Theme.of(context).colorScheme.primary),
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
                            await onDeleteUserUseCase().whenComplete(
                                () => context.go(Screen.authView.path));
                            ;
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
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          child: Container(),
        ),
      ),
    );
  }
}
