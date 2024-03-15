import 'package:flutter/material.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/home/presentation/views/widgets/book/widgets/book_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookScreen extends HookConsumerWidget {
  const BookScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(logDisplayUseCaseProvider).invoke(screen: Screen.booksView.path);

    return BookView();
  }
}
