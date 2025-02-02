import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/style/app_color.dart';

class AppTheme {
  AppTheme._();

  static final _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.ligthScaffold,

    /// NavigationBar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.white,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      elevation: 5,
      shadowColor: AppColor.black,
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(
          color: AppColor.black,
        ),
      ),
    ),

    /// Divider
    dividerTheme: DividerThemeData(
      space: 0,
      color: AppColor.ligthScaffold,
    ),

    /// Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColor.yellow),
      trackColor: WidgetStatePropertyAll(AppColor.white),
      trackOutlineColor: WidgetStatePropertyAll(AppColor.yellow),
    ),

    /// Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.yellow,
    ),
  );

  static final _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkScaffold,

    /// NavigationBar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.black,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      elevation: 5,
      shadowColor: AppColor.black,
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(
          color: AppColor.white,
        ),
      ),
    ),

    /// Divider
    dividerTheme: DividerThemeData(
      space: 0,
      color: AppColor.darkScaffold,
    ),

    /// Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColor.yellow),
      trackColor: WidgetStatePropertyAll(AppColor.black),
      trackOutlineColor: WidgetStatePropertyAll(AppColor.yellow),
    ),

    /// Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.yellow,
    ),
  );

  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}
