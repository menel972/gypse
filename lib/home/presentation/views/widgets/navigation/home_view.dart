// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/home/presentation/views/widgets/navigation/widgets/carousel_view.dart';
import 'package:gypse/open_ai/open_ai_service.dart';
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
          GypseButton.orange(
            context,
            onPressed: () {
              OpenAiService().ask();
              // ref
              //     .read(logNavigationUseCaseProvider)
              //     .invoke(from: Screen.homeView.path, to: Screen.gameView.path);
              // context.go('${Screen.gameView.path}/ ');
            },
            label: 'Mode aléatoire',
          ),
        ),
        Dimensions.xs(context).spaceH(),
      ],
    );
  }
}
