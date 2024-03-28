import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GypseDialog extends HookConsumerWidget {
  final BuildContext context;
  final Widget child;
  final double? height;
  final bool dismissible;
  final Function? onDismiss;

  GypseDialog(
    this.context, {
    required this.child,
    this.height,
    this.dismissible = true,
    this.onDismiss,
    super.key,
  }) {
    showDialog(context: context, builder: (context) => this);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: dismissible,
      onPopInvoked: (_) => onDismiss?.call(),
      child: Center(
        child: Container(
          height: height ?? Dimensions.xxl(context).height,
          width: Dimensions.screen(context).width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.surface),
          ),
          child: Blur(
            blur: 3,
            blurColor: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            overlay: Dimensions.xxs(context).padding(child),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
