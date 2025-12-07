
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam/Features/Auth/api/api_client.dart';
import 'package:online_exam/Features/Profile/api/api_client.dart';
import 'package:online_exam/Features/Subject/api/api_client.dart';
import 'package:online_exam/core/SharedPref.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class ApiModule{


  @singleton
  ApiClient provideApiClient(Dio dio){
    return ApiClient(dio,baseUrl: 'https://exam.elevateegy.com/api/v1/');
  }

  @singleton
  HomeApiClient provideHomeApiClient(Dio dio) {
     return HomeApiClient(dio , baseUrl: 'https://exam.elevateegy.com/api/v1/');
}
  @singleton
  ProfileApiClient provideProfileApiClient(Dio dio) {
    return ProfileApiClient(dio , baseUrl: 'https://exam.elevateegy.com/api/v1/');
  }

    @singleton
    @singleton
    Dio provideDio(BaseOptions options, PrettyDioLogger dioLogger, SharedPreferencesHelper prefs) {
      final dio = Dio(options);
      dio.interceptors.add(dioLogger);

      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await prefs.getToken();
          if (token != null) {
            options.headers["token"] = token;
          }
          return handler.next(options);
        },
      ));

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
