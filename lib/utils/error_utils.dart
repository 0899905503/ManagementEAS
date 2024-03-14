import 'package:dio/dio.dart';

class ErrorUtils {
  const ErrorUtils._();

  static String errorToString({
    required dynamic error,
  }) {
    if (error is! DioException) return 'S.current.somethings_went_wrong';

    /// TODO xử lí case lỗi hệ thống: 404, 405, 429, 500 ...
    final dioError = error;
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return "Please check your network connection!";
    }

    switch (dioError.response?.statusCode) {
      case 403: // Không có quyền
        return 'S.current.no_permission';
      case 404: // Sai url
      case 405: // Thường sai method (GET, POST, PUT...)
      case 429: // Spam api
      case 500: // Lỗi hệ thống
        return ' S.current.somethings_went_wrong';
      case 400:
      case 401:
        try {
          String? msg = dioError.response?.data["message"];
          if (msg != null && msg.isNotEmpty) {
            return msg;
          }
        } catch (e) {
          return 'S.current.somethings_went_wrong';
        }
        return 'S.current.somethings_went_wrong';
      default:
        return ' S.current.somethings_went_wrong';
    }
  }
}
