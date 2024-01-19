import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/analytics/domain/usecase/firebase_analytics_use_cases.dart';
import 'package:gypse/common/providers/connectivity_provider.dart';
import 'package:gypse/common/style/dialogs.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/common/utils/network_error_screen.dart';
import 'package:gypse/home/presentation/views/widgets/book/widgets/book_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookScreen extends HookConsumerWidget {
  const BookScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityNotifierProvider, (previous, next) {
      if (next == ConnectivityResult.none) {
        GypseDialog(
          context,
          dismissible: false,
          height: Dimensions.xl(context).height,
          child: const NetworkErrorScreen(),
        );
      }
    });

    ref.read(logDisplayUseCaseProvider).invoke(screen: Screen.booksView.path);

    return BookView();
  }
}
