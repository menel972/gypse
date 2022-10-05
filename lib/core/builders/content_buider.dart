import 'package:flutter/material.dart';
import 'package:gypse/core/builders/error_builder.dart';
import 'package:gypse/core/builders/loading_builder.dart';

/// A [StatelessWidget] used to consumed datas from a builder
class ContentBuilder extends StatelessWidget {
  final Widget child;
  final bool hasError;
  final String? message;
  final bool hasData;

  const ContentBuilder(
      {super.key,
      required this.hasData,
      required this.hasError,
      required this.child,
      this.message});

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      debugPrint(message);
      return const ErrorBuiler();
    }
    if (!hasData) {
      debugPrint('Pas de donnée');
      return const ErrorBuiler();
    }
    if (hasData) return child;
    return const LoadingBuiler();
  }
}
