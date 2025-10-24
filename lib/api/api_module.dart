import 'package:injectable/injectable.dart';
import 'package:online_exam/api/api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

//If i had a class , that class doesn't implemented by me
@module // because apiClient abstract class without implementation
abstract class ApiModule {
  @singleton
  ApiClient providerApiClient(Dio dio) {
    return ApiClient(dio, baseUrl: 'https://exam.elevateegy.com/api/v1/');
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
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );
  }

  @singleton
  BaseOptions provideOptions() {
    var options = BaseOptions(
        sendTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60));
    return options;
  }
}
