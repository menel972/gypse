import 'package:flutter/material.dart';
import 'package:gypse/core/builders/builders.dart';

/// A [StatelessWidget] used to consumed datas from a builder
class ContentBuilder extends StatelessWidget {
  final Widget child;
  final bool hasError;
  final String? message;
  final bool hasData;
  final bool question;

  const ContentBuilder(
      {super.key,
      required this.hasData,
      required this.hasError,
      required this.child,
      this.message,
      this.question = false});

  @override
  Widget build(BuildContext context) {
    if (hasError && !question) {
      debugPrint('Content Builder Error : $message');
      return const ErrorBuiler();
    }
    if (hasError && question) {
      debugPrint('Content Builder : Pas de donnée');
      return const NoQuestionBuiler();
    }
    if (!hasData) {
      debugPrint('Content Builder : Pas de donnée');
      return const ErrorBuiler();
    }
    if (hasData) return child;
    return const LoadingBuiler();
  }
}
