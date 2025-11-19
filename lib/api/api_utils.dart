import 'package:dio/dio.dart';
import 'package:online_exam/api/model/response/ServerErrorResponse.dart';
import 'package:online_exam/domain/exceptions/custome_exception.dart';
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
        {
          final data = ex.response?.data;
          final statusCode = ex.response?.statusCode;
          ServerErrorResponse response = ServerErrorResponse.fromJson(data);

          // تفاصيل الأخطاء
          String errorDetails = "";
          if (data != null && data['errors'] != null) {
            if (data['errors'] is Map) {
              data['errors'].forEach((key, value) {
                errorDetails += "$key: $value\n";
              });
            } else {
              errorDetails = data['errors'].toString();
            }
          }

          print("===== SERVER ERROR =====");
          print("Status Code: $statusCode");
          print("Message: ${response.message}");
          print("Errors Details: $errorDetails");
          print("Full Response Body: $data");
          print("========================");

          return Failure(ServerError(
            message: response.message ?? "",
            statusMessage: errorDetails.isNotEmpty ? errorDetails : response.statusMessage ?? "",
          ));
        }
    }
  } catch (ex) {
    print("===== UNEXPECTED ERROR =====");
    print(ex);
    print("============================");
    return Failure(UnExpectedError());
  }
}
