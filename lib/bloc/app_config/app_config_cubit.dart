import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../style/app_theme.dart';

part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  static Locale defaultLocale = Locale('en');
  static ThemeData themeData = AppTheme.darkTheme;

  AppConfigCubit()
      : super(AppConfigInitialState(
          locale: defaultLocale,
          themeData: themeData,
        ));

  void updateLocale(Locale locale) {
    emit(AppConfigUpdateLocaleState(locale: locale));
  }

  void updateTheme(bool isDarkModeOn) {
    emit(AppConfigUpdateThemeState(
      themeData: isDarkModeOn ? AppTheme.darkTheme : AppTheme.lightTheme,
    ));
  }
}
