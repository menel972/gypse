import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/extensions.dart';

class GypseSnackBar extends SnackBar {
  final BuildContext context;
  final Object message;

  GypseSnackBar.success(this.context, {required this.message, super.key})
      : super(
          content: Text(message.toString(), style: const GypseFont.s()),
          backgroundColor: const Color.fromRGBO(207, 109, 18, 1),
          duration: 5.seconds,
          padding: Dimensions.xxs(context).pad(),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          showCloseIcon: true,
          dismissDirection: DismissDirection.horizontal,
        );

  GypseSnackBar.error(this.context, {required this.message, super.key})
      : super(
          content: Text(message.toString(), style: const GypseFont.s()),
          backgroundColor: const Color.fromRGBO(176, 0, 32, 1),
          duration: 5.seconds,
          padding: Dimensions.xxs(context).pad(),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          showCloseIcon: true,
          dismissDirection: DismissDirection.horizontal,
        );
}
