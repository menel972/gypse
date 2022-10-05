import 'package:flutter/material.dart';
import 'package:gypse/core/themes/theme.dart';

/// A centered [CircularProgressIndicator] displayed when an error occured with a builder
class ErrorBuiler extends Center {
  const ErrorBuiler({super.key});

  @override
  Widget? get child => const CircularProgressIndicator(color: Couleur.error);
}
