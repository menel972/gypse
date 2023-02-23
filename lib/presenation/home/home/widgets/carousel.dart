import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/books_domain_provider.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

class Carousel extends riverpod.ConsumerStatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  riverpod.ConsumerState<Carousel> createState() => _CarouselState();
}

class _CarouselState extends riverpod.ConsumerState<Carousel> {
  final _provider = BooksDomainProvider().fetchFiveRandomBooksUsecaseProvider;
  final CarouselController controller = CarouselController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      controller.nextPage(duration: const Duration(milliseconds: 600));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.read(_provider).getFiveRandomBooks(context);
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;
    return FlutterCarousel.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) => CarouselCard(context,
          book: books[index], userQuestions: user.questions),
      options: Options(context, controller),
    );
  }
}

/// Extends [CarouselOptions] to provides parameters for [FlutterCarousel]
class Options extends CarouselOptions {
  final BuildContext context;
  final CarouselController carouselController;

  Options(this.context, this.carouselController);

  @override
  double? get height => screenSize(context).height * 0.33;

  @override
  bool get enableInfiniteScroll => true;

  @override
  bool get showIndicator => false;

  @override
  double get viewportFraction => 0.55;

  @override
  bool? get enlargeCenterPage => true;

  @override
  CarouselController? get controller => carouselController;
}
