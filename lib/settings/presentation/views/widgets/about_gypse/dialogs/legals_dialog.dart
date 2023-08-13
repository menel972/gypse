import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gypse/common/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LegalsDialog extends HookConsumerWidget {
  final BuildContext context;
  final Legals legals;
  final Uint8List bytes;

  LegalsDialog(this.context, this.legals, this.bytes, {super.key}) {
    showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Image.memory(bytes),
    );
  }
}
