part of 'app_config_cubit.dart';

@freezed
class AppConfigStateData with _$AppConfigStateData {
  const factory AppConfigStateData({
    final Locale? locale,
    final ThemeData? themeData,
    final String? version,
  }) = _AppConfigStateData;
}

@freezed
class AppConfigState with _$AppConfigState {
  const factory AppConfigState.initialState(
    AppConfigStateData data,
  ) = _InitialState;
  const factory AppConfigState.updateLocaleState(
    AppConfigStateData data,
  ) = UpdateLocaleState;
  const factory AppConfigState.updateThemeDataState(
    AppConfigStateData data,
  ) = UpdateThemeDataState;
}
