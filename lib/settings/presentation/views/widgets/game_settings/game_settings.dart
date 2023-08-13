import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/usecase/user_use_case.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/settings/presentation/views/widgets/game_settings/level_settings.dart';
import 'package:gypse/settings/presentation/views/widgets/game_settings/time_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameSettings extends HookConsumerWidget {
  const GameSettings({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UiUser? user = ref.watch(userProvider);

    onUserChangedUseCase(BuildContext context, UiUser user) =>
        ref.read(onUserChangedUseCaseProvider).invoke(context, user);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Paramètres du jeu',
            style: GypseFont.m(),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/home_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.only(
              top: Dimensions.xs(context).height,
              left: Dimensions.xs(context).width,
              right: Dimensions.xs(context).width,
            ),
            itemCount: 3,
            separatorBuilder: (context, index) {
              return index == 0
                  ? Dimensions.xxs(context).spaceH()
                  : Dimensions.xs(context).spaceH();
            },
            itemBuilder: (context, index) => [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                  border: Border.all(
                    color: const Color.fromRGBO(70, 96, 192, 1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: Dimensions.xxs(context).pad(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Nombre de propositions :', style: GypseFont.m()),
                    LevelSettings(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                  border: Border.all(
                    color: const Color.fromRGBO(70, 96, 192, 1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: Dimensions.xxs(context).pad(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Temps :', style: GypseFont.m()),
                    TimeSettings(),
                  ],
                ),
              ),
              Row(children: [
                Expanded(
                  child: GypseElevatedButton(
                    context,
                    onPressed: () => Navigator.of(context).pop(),
                    label: 'Annuler',
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Dimensions.xxs(context).spaceW(),
                Expanded(
                  child: GypseElevatedButton(
                    context,
                    onPressed: () {
                      if (!user.isNull) {
                        onUserChangedUseCase(context, user!);
                      } else {
                        'No User Error'.failure(context);
                      }
                      Navigator.of(context).pop();
                    },
                    label: 'Valider',
                    textColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ]),
            ][index],
          ),
        ),
      ),
    );
  }
}
