import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/navigation/widgets/carousel_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.homeView.path, details: 'Home');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: CarouselView()),
        Dimensions.s(context).paddingW(
          GypseElevatedButton(
            context,
            onPressed: () {
              ref
                  .read(logNavigationUseCaseProvider)
                  .invoke(from: Screen.homeView.path, to: Screen.gameView.path);
              context.go('${Screen.gameView.path}/ ');
            },
            label: 'Commencer',
            textColor: Theme.of(context).colorScheme.onSurface,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Dimensions.s(context).paddingW(
          GypseElevatedButton(
            context,
            onPressed: () {
              ref.read(logNavigationUseCaseProvider).invoke(
                  from: Screen.homeView.path, to: Screen.booksView.path);
              context.go(Screen.booksView.path);
            },
            label: 'Choisir un livre',
            textColor: Theme.of(context).colorScheme.secondaryContainer,
            backgroundColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.2),
          ),
        ),
        Dimensions.xs(context).spaceH(),
      ],
    );
  }
}
