import 'package:flutter/material.dart';

/// A class that provides datas from the current user
class IsAnsweredMenu extends ChangeNotifier {
  bool _isAnswered = false;

  bool get isAnswered => _isAnswered;

  /// Defines if the user has selected an answer
  void setAnswered(bool boolean) {
    _isAnswered = boolean;
    notifyListeners();
  }
}
