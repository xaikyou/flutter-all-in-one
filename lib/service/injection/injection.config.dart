// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../app_settings/app_settings_service_impl.dart' as _i272;
import '../connectivity/connectivity_service.dart' as _i528;
import '../remote_config/remote_config_service.dart' as _i137;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.factory<_i528.ConnectivityService>(() => _i528.ConnectivityService());
    await gh.factoryAsync<_i137.RemoteConfigService>(
      () => injectionModule.remoteConfigService,
      preResolve: true,
    );
    gh.lazySingleton<_i272.AppSettingsService>(
        () => _i272.AppSettingsServiceImpl());
    return this;
  }
}

class _$InjectionModule extends _i464.InjectionModule {}
