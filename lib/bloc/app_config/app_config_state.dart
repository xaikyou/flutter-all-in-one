part of 'app_config_cubit.dart';

abstract class AppConfigState {
  final Locale? locale;
  final ThemeData? themeData;

  const AppConfigState({
    this.locale,
    this.themeData,
  });
}

class AppConfigInitialState extends AppConfigState {
  AppConfigInitialState({
    required super.locale,
    required super.themeData,
  });
}

class AppConfigUpdateLocaleState extends AppConfigState {
  AppConfigUpdateLocaleState({required super.locale});
}

class AppConfigUpdateThemeState extends AppConfigState {
  AppConfigUpdateThemeState({required super.themeData});
}
