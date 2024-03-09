import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/views/states/recap_session_state.dart';
import 'package:gypse/recap/presentation/views/widgets/recap_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecapScreen extends HookConsumerWidget {
  const RecapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        ref.read(recapSessionStateNotifierProvider.notifier).clearState();
        context.go(Screen.homeView.path);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/home_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: RecapView(),
        ),
      ),
    );
  }
}
