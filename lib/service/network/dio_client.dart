import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    final baseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    dio.options = baseOptions;

    dio.interceptors.add(QueuedInterceptorsWrapper(
      //
      // Handle request before sending to server
      //
      onRequest: (options, handler) {
        // final appPrefs = getIt<AppPrefsServiceHelper>();

        String? accessToken;
        String? expiredTime;
        String? refreshToken;

        if (accessToken == null ||
            expiredTime == null ||
            refreshToken == null) {
          return handler.next(options);
        }

        final expiredTimeConvert = DateTime.parse(expiredTime);
        final isExpired = DateTime.now().isAfter(expiredTimeConvert);

        if (isExpired) {
        } else {
          options.headers['Authorization'] = "Bearer $accessToken";
          return handler.next(options);
        }

        return handler.next(options);
      },

      //
      // Handle response before sending to server
      //
      onResponse: (response, handler) {
        return handler.next(response);
      },

      //
      // Handle error response before sending to server
      //
      onError: (error, handler) {
        String? refreshToken;

        if (error.response?.statusCode == 401) {}

        FirebaseCrashlytics.instance.recordError(
          error.response ?? error,
          error.stackTrace,
        );
        return handler.next(error);
      },
    ));
  }
}
