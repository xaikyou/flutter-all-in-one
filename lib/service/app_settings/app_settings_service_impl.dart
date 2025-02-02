import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_settings_service.dart';

@LazySingleton(as: AppSettingsService)
class AppSettingsServiceImpl implements AppSettingsService {
  final String _appLaunchKey = 'app_launch_key';

  @override
  Future<bool> isAppFirstLaunch() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return sharedPreferences.getBool(_appLaunchKey) ?? true;
  }
}
