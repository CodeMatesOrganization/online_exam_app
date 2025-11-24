
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam/Features/Auth/api/api_client.dart';
import 'package:online_exam/Features/Subject/api/api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Dio provideDio(BaseOptions options, PrettyDioLogger dioLogger ) {
      var dio =  Dio(
        options..headers = {
          "Content-Type": "application/json",
          "token" :"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NWY0MDA3Y2MzZGViYTYwZDAzMWEyMSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzYzOTMzODczfQ.WntSYALngGEOYkI_9dXdo2XOloe-1qOFT8fj3Hn7xxM"
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
