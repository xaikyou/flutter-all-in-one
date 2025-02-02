import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityServiceImpl {
  Future<bool> get isConnected => _checkConnectivity();

  Stream<bool> get onConnectivityChange => _connectivityChange.stream;

  final StreamController<bool> _connectivityChange =
      StreamController<bool>.broadcast();

  late final Connectivity _connectivity;

  bool _currentConnectivity = false;

  ConnectivityServiceImpl({Connectivity? connectivity}) {
    _connectivity = connectivity ?? Connectivity();
    _checkConnectivity().then((value) => _currentConnectivity = value);
    _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) async {
    if (results.isNotEmpty) {
      final ConnectivityResult result = results.first;
      final updatedConnectivity =
          await _checkConnectivity(connectivityResult: result);
      if (updatedConnectivity != _currentConnectivity) {
        _currentConnectivity = updatedConnectivity;
        _connectivityChange.add(_currentConnectivity);
      }
    }
  }

  Future<bool> _checkConnectivity(
      {ConnectivityResult? connectivityResult}) async {
    final result =
        connectivityResult ?? await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
