import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/domain/providers/books_domain_provider.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Carousel extends ConsumerStatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  ConsumerState<Carousel> createState() => _CarouselState();
}

class _CarouselState extends ConsumerState<Carousel> {
  final _provider = BooksDomainProvider().fetchFiveRandomBooksUsecaseProvider;
  final CarouselController controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.read(_provider).getFiveRandomBooks(context);
    return FlutterCarousel.builder(
      carouselController: controller,
      itemCount: 5,
      itemBuilder: (context, index, realIndex) => BookCard(book: books[index]),
      options: Options(context),
    );
  }
}

/// Extends [CarouselOptions] to provides parameters for [FlutterCarousel]
class Options extends CarouselOptions {
  final BuildContext context;

  Options(this.context);

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
}
