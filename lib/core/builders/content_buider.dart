import 'package:flutter/material.dart';
import 'package:gypse/core/builders/builders.dart';
import 'package:gypse/core/builders/tips.dart';

/// A [StatelessWidget] used to consumed datas from a builder
class ContentBuilder extends StatelessWidget {
  final Widget child;
  final bool hasError;
  final String? message;
  final bool hasData;
  final bool question;
  final bool data;

  const ContentBuilder(
      {super.key,
      required this.hasData,
      required this.hasError,
      required this.child,
      required this.data,
      this.message,
      this.question = false});

  @override
  Widget build(BuildContext context) {
    if (hasError && !question) {
      debugPrint('Content Builder Error : $message');
      return const ErrorBuiler();
    }
    if (hasError && question) {
      debugPrint('Content Builder : error');
      return const NoQuestionBuiler();
    }
    if (!hasData) {
      debugPrint('Content Builder : Pas de donnée');
      return Tips();
    }
    if (hasData && !data) {
      debugPrint('Content Builder : data - loading');
      return const LoadingBuiler();
    }
    if (hasData && data) return child;
    debugPrint('Content Builder : loading');
    return const LoadingBuiler();
  }
}
