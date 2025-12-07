
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam/core/api/api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class ApiModule{
  @singleton
  ApiClient provideApiClient(Dio dio){
    return ApiClient(dio,baseUrl: 'https://exam.elevateegy.com/api/v1/');
  }

  @singleton
  Dio provideDio(BaseOptions options, PrettyDioLogger dioLogger ){
    var dio =  Dio(
      options..headers = {
        "Content-Type": "application/json",
      },
    );
    dio.interceptors.add(dioLogger);
    return dio;
  }


  @singleton
  PrettyDioLogger provideDioLogger(){
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: false,
    );
  }



  @singleton
  BaseOptions provideOptions(){
    var options = BaseOptions(
        sendTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60)
    );
    return options;
  }
}