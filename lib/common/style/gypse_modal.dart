import 'package:flutter/material.dart';

class GypseModal extends StatelessWidget {
  final BuildContext initialContext;
  final Widget child;
  final double? heightFactor;
  final bool dismissible;

  GypseModal(
    this.initialContext, {
    required this.child,
    this.dismissible = true,
    this.heightFactor,
    super.key,
  }) {
    showModalBottomSheet(
      context: initialContext,
      isDismissible: dismissible,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor:
          Theme.of(initialContext).colorScheme.surface.withOpacity(0.9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor ?? 0.59,
      child: child,
    );
  }
}
