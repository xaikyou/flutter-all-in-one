import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/model/app_version_response.dart';
import 'package:flutter_all_in_one/service/app_settings/app_settings_service_impl.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../service/injection/injection.dart';
import '../../style/app_theme.dart';

part 'app_config_cubit.freezed.dart';
part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  final AppSettingsService _appSettings;
  final RemoteConfigService _remoteConfig;

  static Locale defaultLocale = Locale('en');
  static ThemeData themeData = AppTheme.lightTheme;

  static Map<String, String> languageNames = {
    'en': 'English',
    'vi': 'Việt Nam',
  };

  AppConfigCubit()
      : _appSettings = getIt<AppSettingsService>(),
        _remoteConfig = getIt<RemoteConfigService>(),
        super(_InitialState(AppConfigStateData(
          locale: defaultLocale,
          themeData: themeData,
        )));

  void init() async {
    getAppInfo();
    checkForUpdate();

    bool isAppLaunched = await _appSettings.isAppFirstLaunch();
    emit(_InitialState(state.data.copyWith(isFirstLaunch: isAppLaunched)));
  }

  void getAppInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version = packageInfo.version;
      // String appName = packageInfo.appName;
      // String packageName = packageInfo.packageName;
      // String buildNumber = packageInfo.buildNumber;
      emit(_InitialState(state.data.copyWith(version: version)));
    });
  }

  void checkForUpdate() {
    AppVersionResponse response = AppVersionResponse.fromRawJson(
        _remoteConfig.getValue(RemoteConfigKey.version));
    if (response.version != state.data.version) {
      print("updated version available");
    }
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
