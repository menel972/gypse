import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/bloc/bloc_provider.dart';
import 'package:gypse/core/builders/content_buider.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:gypse/presenation/components/tiles.dart';
import 'package:gypse/presenation/home/bloc/settings_bloc.dart';
import 'package:gypse/presenation/home/bloc/settings_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

class SettingsModal extends riverpod.HookConsumerWidget {
  const SettingsModal({super.key});

  static Future<void> showSettings(BuildContext context, GypseUser user) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) => BlocProvider(
          bloc: SettingsBloc(SettingsState.fromSettings(user.settings)),
          child: const SettingsModal()),
    );
  }

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    GypseUser user = Provider.of<CurrentUser>(context).currentUser;

    void updateUser(Settings settings) =>
        Provider.of<CurrentUser>(context, listen: false)
            .setSettingsUser(settings);

    Future<void> updateFirebaseUser(GypseUser user) async => await ref
        .read(UsersDomainProvider().updateFirebaseUserUsecaseProvider)
        .updateFirebaseUser(user);

    return StreamBuilder<SettingsState>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return ContentBuilder(
            hasData: snapshot.hasData,
            hasError: snapshot.hasError,
            message: '${snapshot.error}',
            child: Blur(
              blur: 1,
              blurColor: Couleur.primarySurface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              overlay: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                padding: EdgeInsets.symmetric(
                  vertical: screenSize(context).height * 0.1,
                  horizontal: screenSize(context).width * 0.03,
                ),
                separatorBuilder: (context, index) {
                  switch (index) {
                    case 1:
                      return SizedBox(
                          height: screenSize(context).height * 0.02);
                    case 3:
                      return SizedBox(
                          height: screenSize(context).height * 0.05);
                    default:
                      return SizedBox(height: screenSize(context).height * 0);
                  }
                },
                itemBuilder: (context, index) => [
                  AutoSizeText(
                    '${words(context).title_diff} :',
                    style: const TextM(Couleur.primary),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SettingsRadioButton(
                          textTitle: words(context).label_easy,
                          textSubTitle: '2 ${words(context).sub_choix}',
                          value: Level.easy,
                          groupValue: snapshot.data!.level,
                          onChanged: (value) => bloc.setLevel(value),
                        ),
                      ),
                      Expanded(
                        child: SettingsRadioButton(
                          textTitle: words(context).label_medium,
                          textSubTitle: '3 ${words(context).sub_choix}',
                          value: Level.medium,
                          groupValue: snapshot.data!.level,
                          onChanged: (value) => bloc.setLevel(value),
                        ),
                      ),
                      Expanded(
                        child: SettingsRadioButton(
                          textTitle: words(context).label_hard,
                          textSubTitle: '4 ${words(context).sub_choix}',
                          value: Level.hard,
                          groupValue: snapshot.data!.level,
                          onChanged: (value) => bloc.setLevel(value),
                        ),
                      ),
                    ],
                  ),
                  AutoSizeText(
                    '${words(context).title_chrono} :',
                    style: const TextM(Couleur.primary),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SettingsRadioButton(
                          textTitle: words(context).label_easy,
                          textSubTitle: '30 ${words(context).sub_time}',
                          value: Time.easy,
                          groupValue: snapshot.data!.time,
                          onChanged: (value) => bloc.setTime(value),
                        ),
                      ),
                      Expanded(
                        child: SettingsRadioButton(
                          textTitle: words(context).label_medium,
                          textSubTitle: '20 ${words(context).sub_time}',
                          value: Time.medium,
                          groupValue: snapshot.data!.time,
                          onChanged: (value) => bloc.setTime(value),
                        ),
                      ),
                      Expanded(
                        child: SettingsRadioButton(
                          textTitle: words(context).label_hard,
                          textSubTitle: '12 ${words(context).sub_time}',
                          value: Time.hard,
                          groupValue: snapshot.data!.time,
                          onChanged: (value) => bloc.setTime(value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          context,
                          text: words(context).btn_annule,
                          onPressed: () => Navigator.of(context).pop(),
                          textColor: Couleur.primary,
                          color: Couleur.primarySurface,
                        ),
                      ),
                      SizedBox(width: screenSize(context).width * 0.03),
                      Expanded(
                        child: PrimaryButton(
                          context,
                          text: words(context).btn_valide,
                          onPressed: () {
                            updateUser(snapshot.data!.toSettings());
                            updateFirebaseUser(user);
                            Navigator.of(context).pop();
                          },
                          color: Couleur.primary,
                          textColor: Couleur.primarySurface,
                        ),
                      ),
                    ],
                  )
                ][index],
              ),
              child: Container(),
            ),
          );
        });
  }
}
