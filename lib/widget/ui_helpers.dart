import 'package:flutter/material.dart';

class UiHelpers {
  UiHelpers._();

  /// Dismiss key board
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
