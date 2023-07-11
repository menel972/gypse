// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarouselView extends StatefulHookConsumerWidget {
  CarouselView({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarouselViewState();

  List<Books> fetchFiveRandomBooks() {
    List<Books> books = [...Books.values];
    books.shuffle();
    return books.take(5).toList();
  }
}

class _CarouselViewState extends ConsumerState<CarouselView> {
  late List<Books> books;
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    List<Books> allBooks = [...Books.values];
    allBooks.shuffle();

    books = allBooks.take(5).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) => HomeCarouselCard(
        context,
        book: books[index],
        function: () {},
        onCtaPressed: () {},
      ),
      options: Options(context, carouselController),
    );
  }
}

/// Extends [CarouselOptions] to provides parameters for [FlutterCarousel]
class Options extends CarouselOptions {
  final BuildContext context;
  final CarouselController carouselController;

  Options(this.context, this.carouselController);

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

  @override
  CarouselController? get controller => carouselController;
}
