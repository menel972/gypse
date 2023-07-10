// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gypse/auth/presentation/models/ui_user.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/home/presentation/views/widgets/profile/widgets/admin_view.dart';
import 'package:gypse/home/presentation/views/widgets/profile/widgets/user_credentials_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileView extends HookConsumerWidget {
  late UiUser? user;

  UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = ref.watch(userProvider);

    return Padding(
      padding: EdgeInsets.only(top: Dimensions.s(context).height),
      child: DefaultTabController(
        length: user!.isAdmin ? 2 : 1,
        child: Column(children: [
          TabBar(
            tabs: user!.isAdmin
                ? [Text('Mon Profile'), Text('Questions')]
                : [Text('Mon Profile')],
            isScrollable: true,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            indicatorSize: TabBarIndicatorSize.label,
            overlayColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            indicatorWeight: 1.5,
            dividerColor: Colors.transparent,
            labelColor: Theme.of(context).colorScheme.secondary,
            labelStyle: GypseFont.m(bold: true),
            unselectedLabelStyle: GypseFont.m(bold: false),
          ),
          Expanded(
              child: TabBarView(
            children: user!.isAdmin
                ? [UserCredentialsView(), AdminView()]
                : [UserCredentialsView()],
          )),
        ]),
      ),
    );
  }
}
