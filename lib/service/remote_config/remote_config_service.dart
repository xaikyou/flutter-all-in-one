import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_all_in_one/service/injection/injection.dart';

import '../connectivity/connectivity_service.dart';

enum RemoteConfigKey {
  text('text', 'Hello World!');

  final String name;
  final dynamic defaultValue;

  const RemoteConfigKey(this.name, this.defaultValue);
}

class RemoteConfigService {
  final StreamController<Map<RemoteConfigKey, dynamic>>
      _remoteConfigUpdateStream =
      StreamController<Map<RemoteConfigKey, dynamic>>.broadcast();

  Stream<Map<RemoteConfigKey, dynamic>> get remoteConfigStream =>
      _remoteConfigUpdateStream.stream;

  final FirebaseRemoteConfig _remoteConfig;
  final ConnectivityService _connectivityService;

  RemoteConfigService(
      {FirebaseRemoteConfig? remoteConfig,
      ConnectivityService? connectivityService})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance,
        _connectivityService =
            connectivityService ?? getIt<ConnectivityService>();

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 15),
    ));

    if (await _connectivityService.isConnected) {
      await _remoteConfig.fetchAndActivate();
      _onRemoteConfigValueUpdate();
    }
    _connectivityService.onConnectivityChange.listen((event) async {
      if (event) {
        await _remoteConfig.fetchAndActivate();
        _onRemoteConfigValueUpdate();
      }
    });
  }

  void _onRemoteConfigValueUpdate() {
    final Map<RemoteConfigKey, dynamic> map = {};

    for (RemoteConfigKey key in RemoteConfigKey.values) {
      map.putIfAbsent(key, () => getValue(key));
    }
    _remoteConfigUpdateStream.add(map);
  }

  dynamic getValue(RemoteConfigKey key) {
    if (key.defaultValue is bool) {
      return _remoteConfig.getBool(key.name);
    } else if (key.defaultValue is int) {
      return _remoteConfig.getInt(key.name);
    } else if (key.defaultValue is double) {
      return _remoteConfig.getDouble(key.name);
    } else if (key.defaultValue is String) {
      return _remoteConfig.getString(key.name);
    }

    throw UnsupportedError(
        'Remote config value not supported ${key.defaultValue}');
  }
}
