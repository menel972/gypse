import 'package:flutter/material.dart';
import 'package:gypse/core/themes/theme.dart';

/// A centered [CircularProgressIndicator] displayed when a builder's value is loading
class LoadingBuiler extends Center {
  const LoadingBuiler({super.key});

  @override
  Widget? get child =>
      const CircularProgressIndicator(color: Couleur.secondary);
}
