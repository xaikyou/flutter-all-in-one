import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient() {
    final baseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    Dio dio = Dio();
    dio.options = baseOptions;
    dio.interceptors.clear();
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        // final appPrefs = getIt<AppPrefsServiceHelper>();
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));

    return _RestClient(dio, baseUrl: '');
  }
}
