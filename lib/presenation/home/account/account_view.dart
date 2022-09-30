import 'package:flutter/material.dart';
import 'package:gypse/core/commons/mocks.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/providers/account_domain_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// User personal view
///
/// AccountView allows users to access to his personal datas
class AccountView extends HookConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAdmin = userMock.isAdmin;

    return DefaultTabController(
      length: isAdmin ? 2 : 1,
      child: Column(
        children: [
          TabBar(
            tabs: ref
                .read(AccountDomainProvider().getLabelsUsecaseProvider)
                .getLabelsUsecase(context, isAdmin),
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
                  .getViewsUsecase(isAdmin),
            ),
          )
        ],
      ),
    );
  }
}
