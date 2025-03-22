import 'package:dio/dio.dart';
import 'package:flutter_all_in_one/service/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '')
abstract class RestClient {
  factory RestClient({Dio? dio, String? baseUrl}) {
    dio ??= DioClient().dio;
    return _RestClient(dio, baseUrl: baseUrl);
  }
}
