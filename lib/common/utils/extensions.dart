import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
/// Pads adds methods [padW], [padH], [pad], [paddingW], [paddingH] and [padding] that return symmetric [Padding] with either horizontal or vertical value set from the Dimensions object.
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
  /// Returns an [EdgeInsets] with **value** set from the width of the Dimensions object.
  EdgeInsets pad() => EdgeInsets.all(width);

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

  ///## Extension on [Dimensions]
  ///
  /// Returns an [Padding] with **value** set from the width of the Dimensions object.
  Padding padding(Widget? child) {
    return Padding(
      padding: EdgeInsets.all(width),
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
  void log({String? tag}) =>
      debugPrint('${tag.isNull ? '[]' : '[$tag] :'} $this');
}

///## Extension on any [Object]
///
/// Wheather the object is null.
extension Null on Object? {
  ///## Extension on any [Object]
  ///
  /// Wheather the object is null..
  bool get isNull => this == null;
}

extension Value on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
  bool get isNotNullOrEmpty => this?.isEmpty ?? false;
}

///## Extension on [String]
///
/// Snack adds methods [success] and [failure] that return custom [SnackBar].
extension Snack on Object {
  ///## Extension on [String]
  ///
  /// Returns a [SnackBar] with a custom appearance.<br>
  /// Use it to **inform the user of a successful event**.
  void success(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(toString(), style: const GypseFont.xs()),
        backgroundColor: const Color.fromRGBO(207, 109, 18, 1),
        duration: const Duration(seconds: 5),
      ));

  ///## Extension on [String]
  ///
  /// Returns a [SnackBar] with a custom appearance.<br>
  /// Use it to **inform the user of a failure**.
  void failure(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          toString(),
          style: const GypseFont.xs(),
        ),
        backgroundColor: const Color.fromRGBO(176, 0, 32, 1),
        duration: const Duration(seconds: 5),
      ));
}

///## Extension on [String]
///
/// Launches the given URL and open it in a web view on an external platform.
extension WebView on String {
  ///## Extension on [String]
  ///
  /// Launches the given URL and open it in a web view on an external platform.<br>
  /// Errors are handled and displayed in a failure [SnackBar].
  Future<void> launch(BuildContext context) async {
    try {
      launchUrlString(this, mode: LaunchMode.externalApplication);
    } on PlatformException catch (e) {
      e.message?.failure(context);
      e.message?.log();
    }
  }

  Future<void> mailTo(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: this,
    );
    try {
      launchUrl(emailLaunchUri);
    } on PlatformException catch (e) {
      e.message?.failure(context);
      e.message?.log();
    }
  }
}

///## Extension on [IconData]
///
/// Display an [Icon] of the given `IconData`.
extension ShowIcon on IconData {
  ///## Extension on [IconData]
  ///
  /// Returns an [Icon] with the given `IconData`.
  Icon show({Color? color = const Color.fromRGBO(196, 196, 196, 1)}) =>
      Icon(this, color: color);
}

///## Extension on [double]
///
/// Convert a number to a percentage string representation.
extension Percent on double {
  /// Converts the number to a percentage string representation.
  ///
  /// If the number is an integer, it returns the integer value as a string.
  /// Otherwise, it returns the number rounded to one decimal place as a string.
  String get toPercent {
    if (this % 1 == 0) return '${toInt()}%';

    return '${toStringAsFixed(1)}%';
  }
}
