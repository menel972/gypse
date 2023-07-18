import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/books/presentation/views/widgets/book_view.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookScreen extends HookConsumerWidget {
  const BookScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(logDisplayUseCaseProvider).invoke(screen: Screen.booksView.path);

    return WillPopScope(
      onWillPop: () async {
        ref.read(logNavigationUseCaseProvider).invoke(
              from: Screen.booksView.path,
              to: Screen.homeView.path,
            );
        context.go(Screen.homeView.path);
        return false;
      },
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () {
            ref.read(logNavigationUseCaseProvider).invoke(
                  from: Screen.booksView.path,
                  to: Screen.homeView.path,
                );
            context.go(Screen.homeView.path);
          },
          icon: Icon(Icons.home_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$imagesPath/game_bkg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BookView(),
        ),
      ),
    );
  }
}
