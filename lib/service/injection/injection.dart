import 'package:flutter_all_in_one/service/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../remote_config/remote_config_service.dart';

final getIt = GetIt.instance;

@module
abstract class InjectionModule {
  @preResolve
  Future<RemoteConfigService> get remoteConfigService async {
    final remoteConfigService = RemoteConfigService();
    await remoteConfigService.init();
    return remoteConfigService;
  }
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
