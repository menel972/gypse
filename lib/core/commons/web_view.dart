import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebView {
  final String url;

  WebView(this.url);

  Future<void> showInternet() async {
    try {
      await launchUrlString(url);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
