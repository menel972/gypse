import 'package:flutter/material.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/account_domain_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

/// User personal view
///
/// AccountView allows users to access to his personal datas
class AccountView extends riverpod.HookConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;
    return DefaultTabController(
      length: user.isAdmin ? 2 : 1,
      child: Column(
        children: [
          TabBar(
            tabs: ref
                .read(AccountDomainProvider().getLabelsUsecaseProvider)
                .getLabelsUsecase(context, user.isAdmin),
            isScrollable: true,
            indicatorColor: Couleur.secondary,
            indicatorSize: TabBarIndicatorSize.label,
            overlayColor:
                MaterialStateProperty.resolveWith((_) => Couleur.secondary),
          ),
          Expanded(
            child: TabBarView(
              children: ref
                  .read(AccountDomainProvider().getViewsUsecaseProvider)
                  .getViewsUsecase(user.isAdmin),
            ),
          )
        ],
      ),
    );
  }
}
