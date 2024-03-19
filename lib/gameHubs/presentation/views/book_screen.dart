import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/books_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/strings.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/gameHubs/presentation/states/book_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'books/book_app_bar.dart';
part 'books/book_view.dart';

/// A screen that displays a book view.
class BookScreen extends HookConsumerWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(logDisplayUseCaseProvider).invoke(screen: Screen.booksView.path);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BookAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$imagesPath/game_bkg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BookView(),
      ),
    );
  }
}
