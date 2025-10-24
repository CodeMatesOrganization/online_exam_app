import 'package:dio/dio.dart';
import 'package:online_exam/api/api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:injectable/injectable.dart';

@module
class ApiModule {

  @singleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio,);
  }

  @singleton
  Dio provideDio(BaseOptions options, PrettyDioLogger dioLogger) {
    var dio = Dio(options);
    dio.interceptors.add(dioLogger);
    return dio;
  }


  @singleton
  PrettyDioLogger provideDioLogger() {
    return PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false
    );
  }
}