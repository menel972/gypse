import 'package:flutter/material.dart';
import 'package:gypse/common/style/dimensions.dart';

///## Extension on [Dimensions]
///
/// Space adds two methods [spaceW] and [spaceH] that return [SizedBox] with either width or height set from the Dimensions object.
extension Space on Dimensions {
  ///## Extension on [Dimensions]
  ///
  /// Returns a [SizedBox] with the width of the Dimensions object.
  SizedBox spaceW() => SizedBox(width: width);

  ///## Extension on [Dimensions]
  ///
  /// Returns a [SizedBox] with the height of the Dimensions object.
  SizedBox spaceH() => SizedBox(height: height);
}

///## Extension on [Dimensions]
///
/// Pads adds four methods [padW], [padH], [paddingW] and [paddingH] that return symmetric [Padding] with either horizontal or vertical value set from the Dimensions object.
extension Pads on Dimensions {
  ///## Extension on [Dimensions]
  ///
  /// Returns a symmetric [EdgeInsets] with **horizontal value** set from the Dimensions object.
  EdgeInsets padW() => EdgeInsets.symmetric(horizontal: width);

  ///## Extension on [Dimensions]
  ///
  /// Returns a symmetric [EdgeInsets] with **vertical value** set from the Dimensions object.
  EdgeInsets padH() => EdgeInsets.symmetric(vertical: height);

  ///## Extension on [Dimensions]
  ///
  /// Returns a symmetric [Padding] with **horizontal value** set from the Dimensions object.
  Padding paddingW(Widget? child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width),
      child: child,
    );
  }

  ///## Extension on [Dimensions]
  ///
  /// Returns a symmetric [Padding] with **vertical value** set from the Dimensions object.
  Padding paddingH(Widget? child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height),
      child: child,
    );
  }
}

///## Extension on any [Object]
///
/// Logs the object to debug console.
extension Print on Object {
  ///## Extension on any [Object]
  ///
  /// Logs the object to debug console using [debugPrint].
  void log() => debugPrint(toString());
}

// extension Snack on String {
//   void sucsess(BuildContext context) =>
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           this,
//           style: const Font.m(color: Colors.black),
//         ),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 5),
//       ));

//   void failure(BuildContext context) =>
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           this,
//           style: const Font.m(color: Colors.black),
//         ),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 5),
//       ));
// }
