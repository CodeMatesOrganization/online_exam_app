import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:online_exam/api/model/response/server_error_response.dart';
import 'package:online_exam/domain/exceptions/custom_exceptions.dart';
import 'package:online_exam/domain/result.dart';

Future<Result<T>> executeApi<T>(Future<T> apiCall()) async {
  try {
    var result = await apiCall.call();
    return Success(result);

  } on DioException catch (ex) {
    switch (ex.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure(ConnectionError());

      default:
        try {
          final data = ex.response?.data;

          if (data is Map<String, dynamic>) {
            final response = ServerResponseError.fromJson(data);
            return Failure(ServerError(
              response.code ?? "",
              response.message ?? "",
            ));
          }

          if (data is String) {
            final response = ServerResponseError.fromJson(jsonDecode(data));
            return Failure(ServerError(
              response.code ?? "",
              response.message ?? "",
            ));
          }

          return Failure(ServerError("", "Unknown server error"));
        } catch (e) {
          return Failure(ServerError("", "Invalid error format"));
        }
    }
  }

  catch (e) {
    return Failure(UnExpectedError());
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:online_exam/api/model/response/server_error_response.dart';
import 'package:online_exam/domain/exceptions/custom_exceptions.dart';