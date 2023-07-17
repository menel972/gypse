import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/books/presentation/views/widgets/book_view.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/strings.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(Screen.homeView.path);
        return false;
      },
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () => context.go(Screen.homeView.path),
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
