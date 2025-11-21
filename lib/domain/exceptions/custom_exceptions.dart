class ConnectionError implements Exception {
  final String message ;
  ConnectionError([this.message = "No internet connection"]);
}

class ServerError implements Exception {
  String message;
  String statusMessage;
  ServerError(this.message, this.statusMessage);

  @override
  String toString() => message.isNotEmpty ? message : "Unknown server error";
}


/// خطأ في البيانات المدخلة من المستخدم (مثل validation errors)
class ValidationError implements Exception {
  final String message;
  ValidationError(this.message);
  @override
  String toString() => message;
}

/// خطأ عام غير معروف
class UnknownError implements Exception {
  final String message;
  UnknownError([this.message = "Something went wrong"]);
  @override
  String toString() => message;
}

/// خطأ في الوصول للصلاحيات أو التفويض (مثل 401 Unauthorized)
class UnauthorizedError implements Exception {
  final String message;
  UnauthorizedError([this.message = "Unauthorized"]);
  @override
  String toString() => message;
}

/// خطأ في المورد المطلوب (مثل 404 Not Found)
class NotFoundError implements Exception {
  final String message;
  NotFoundError([this.message = "Resource not found"]);
  @override
  String toString() => message;
}

/// خطأ في العمليات على البيانات (مثل duplicate أو forbidden)
class DataError implements Exception {
  final String message;
  DataError([this.message = "Invalid data operation"]);
  @override
  String toString() => message;
}
class UnExpectedError implements Exception{}