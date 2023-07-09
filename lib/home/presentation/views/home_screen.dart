import 'package:flutter/material.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/home/presentation/views/states/home_navigation_state.dart';
import 'package:gypse/home/presentation/views/widgets/home_navigation_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int navigationIndex = ref.watch(homeNavigationStateProvider);

    return Scaffold(
        // appBar: HomeAppBar(context, user),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/home_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(child: Text('$navigationIndex')),
        ),
        bottomNavigationBar: HomeNavigationBar());
  }
}
