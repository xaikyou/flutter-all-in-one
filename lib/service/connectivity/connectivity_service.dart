import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'connectivity_service_impl.dart';

@injectable
class ConnectivityService {
  ConnectivityService() {
    _streamSubscription =
        _connectivityPlusImpl.onConnectivityChange.listen((connected) async {
      _connectivityWatcher.add(await isConnected);
    });
  }
  final ConnectivityServiceImpl _connectivityPlusImpl =
      ConnectivityServiceImpl();

  final StreamController<bool> _connectivityWatcher = StreamController();

  late final StreamSubscription<bool> _streamSubscription;

  Future<bool> get isConnected async {
    bool connected = await _connectivityPlusImpl.isConnected;

    if (connected) {
      try {
        Dio dio = Dio();
        final result = await dio.get('https://www.google.com');
        return result.statusCode == 200;
      } on DioException catch (_) {
        return false;
      }
    }
    return false;
  }

  Stream<bool> get onConnectivityChange => _connectivityWatcher.stream;

  Future<void> dispose() async {
    await _streamSubscription.cancel();
  }
}
