import 'package:flutter/material.dart';

class ChangeSliderValue with ChangeNotifier {
  int _currentValue = 51;

  int get currentValue => _currentValue;

  set currentValue(int value) {
    _currentValue = value;
    notifyListeners();
  }
}
