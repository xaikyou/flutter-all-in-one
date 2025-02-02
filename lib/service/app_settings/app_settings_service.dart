part of 'app_settings_service_impl.dart';

abstract class AppSettingsService {
  AppSettingsService();

  factory AppSettingsService.newInstance() => AppSettingsServiceImpl();

  Future<bool> isAppFirstLaunch();
}
