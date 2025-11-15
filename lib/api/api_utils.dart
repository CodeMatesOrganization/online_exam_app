import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:online_exam/api/model/response/ServerErrorResponse.dart';
import 'package:online_exam/domain/exceptions/custome_exception.dart';
import 'package:online_exam/domain/result.dart';

Future<Result<T>> executeApi<T> (Future<T> apiCall())async{

  try{
    var result = await apiCall.call();
    return Success(result);
  } on DioException catch(ex){
    switch(ex.type){
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        {
          return Failure(ConnectionError());
        }
      default:{
        ServerErrorResponse response =
        ServerErrorResponse.fromJson(ex.response?.data);
        print("THE SERVER ERROR MESSAGE IS ${response.message}");
        return Failure(ServerError(response.message ??"",
            response.statusMessage ??""));
        
      }
    }
  } catch(ex){
    return Failure(UnExpectedError());
  }

}