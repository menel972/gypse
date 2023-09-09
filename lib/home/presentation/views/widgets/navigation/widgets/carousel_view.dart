// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gypse/common/providers/questions_provider.dart';
import 'package:gypse/common/providers/user_provider.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:gypse/game/presentation/models/ui_question.dart';
import 'package:gypse/home/presentation/views/widgets/navigation/states/carousel_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarouselView extends HookConsumerWidget {
  CarouselView({super.key});

  late List<Books> books;
  late List<UiQuestion> questions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    questions = ref.read(questionsProvider.notifier).getEnabledQuestions(
        ref.read(userProvider.notifier).answeredQuestionsId);
    books = ref.watch(carouselStateNotifierProvider(questions));

    return FlutterCarousel.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) => HomeCarouselCard(
        context,
        book: books[index],
        ref: ref,
      ),
      options: Options(context),
    );
  }
}

/// Extends [CarouselOptions] to provides parameters for [FlutterCarousel]
class Options extends CarouselOptions {
  final BuildContext context;

  Options(this.context);

  @override
  double? get height => Dimensions.xl(context).height;

  @override
  bool get enableInfiniteScroll => true;

  @override
  bool get showIndicator => false;

  @override
  double get viewportFraction => 0.7;

  @override
  bool? get enlargeCenterPage => true;

  @override
  bool get autoPlay => true;

  @override
  Duration get autoPlayInterval => const Duration(seconds: 8);

  @override
  Duration get autoPlayAnimationDuration => const Duration(milliseconds: 600);
}
