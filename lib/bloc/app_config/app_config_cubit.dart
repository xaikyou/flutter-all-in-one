import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../style/app_theme.dart';

part 'app_config_cubit.freezed.dart';
part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  static Locale defaultLocale = Locale('en');
  static ThemeData themeData = AppTheme.lightTheme;

  static Map<String, String> languageNames = {
    'en': 'English',
    'vi': 'Việt Nam',
  };

  AppConfigCubit()
      : super(_InitialState(AppConfigStateData(
          locale: defaultLocale,
          themeData: themeData,
        )));

  void getAppInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version = packageInfo.version;
      // String appName = packageInfo.appName;
      // String packageName = packageInfo.packageName;
      // String buildNumber = packageInfo.buildNumber;
      emit(_InitialState(state.data.copyWith(version: version)));
    });
  }

  void updateLocale(Locale locale) {
    emit(UpdateLocaleState(state.data.copyWith(locale: locale)));
  }

  void updateTheme(bool isDarkModeOn) {
    emit(UpdateThemeDataState(state.data.copyWith(
      themeData: isDarkModeOn ? AppTheme.darkTheme : AppTheme.lightTheme,
    )));
  }

  String languageCodeToCountryName(String languageCode) {
    return languageNames[languageCode] ?? '';
  }
}
