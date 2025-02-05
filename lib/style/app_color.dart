import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';

class AppColor {
  AppColor._();

  static const ligthScaffold = Color.fromARGB(255, 235, 235, 235);
  static const darkScaffold = Color.fromARGB(255, 37, 37, 37);
  static const white = Color.fromARGB(255, 250, 250, 250);
  static const black = Color.fromARGB(255, 10, 10, 10);
  static const yellow = Color.fromARGB(255, 240, 193, 48);
  static const grey = Color.fromARGB(255, 200, 200, 200);

  static const selectedNavIcon = yellow;

  static Color getBlackWhite(BuildContext context, {bool? reverse}) {
    return reverse == true
        ? context.isDarkModeOn
            ? AppColor.white
            : AppColor.black
        : context.isDarkModeOn
            ? AppColor.black
            : AppColor.white;
  }

  static Color getBackgroundColor(BuildContext context, {bool? reverse}) {
    return context.isDarkModeOn
        ? AppColor.darkScaffold
        : AppColor.ligthScaffold;
  }
}
