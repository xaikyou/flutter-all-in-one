import 'dart:async';
import 'dart:developer' as dev;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_all_in_one/service/injection/injection.dart';

import '../connectivity/connectivity_service.dart';

enum RemoteConfigKey {
  text('text', 'Hello World!'),
  version('version', 'Hello World!');

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

  Set<String> _updatedKeys = {};
  Set<String> get updatedKeys => _updatedKeys;

  RemoteConfigService(
      {FirebaseRemoteConfig? remoteConfig,
      ConnectivityService? connectivityService})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance,
        _connectivityService =
            connectivityService ?? getIt<ConnectivityService>();

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    /// Checks which keys have been updated
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      _updatedKeys = event.updatedKeys;
      _onRemoteConfigValueUpdate.call();
    }, onError: (e) {
      // Ignore RC errors
    });

    if (await _connectivityService.isConnected) {
      await _remoteConfig.fetchAndActivate();
    }
    _connectivityService.onConnectivityChange.listen((event) async {
      if (event) {
        await updateValue();
      }
    });
  }

  Future<void> updateValue() async {
    try {
      bool updated = await _remoteConfig.activate().then((_) async {
        return await _remoteConfig.fetchAndActivate();
      });
      if (updated) {
        _onRemoteConfigValueUpdate();
      }
    } catch (e) {
      dev.log('Error fetching remote config: $e');
    }
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
