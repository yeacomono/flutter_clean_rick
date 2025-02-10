import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer();

    buffer.writeln("\x1B[31m❌ ====================== ERROR ==========================\x1B[0m");
    buffer.writeln("\x1B[31m❌ STATUS: ${err.response?.statusCode ?? 'Unknown'}\x1B[0m");
    buffer.writeln("\x1B[31m❌ URL: ${err.requestOptions.uri}\x1B[0m");
    buffer.writeln("\x1B[31m❌ MESSAGE: ${err.message}\x1B[0m");

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      buffer.writeln("\x1B[33m⏳ Timeout error: ${err.message}\x1B[0m");

      err = DioException(
        requestOptions: err.requestOptions,
        error: "⏳ Tiempo de espera agotado.",
      );
    } else {
      buffer.writeln("\x1B[31m❌ Dio error: ${err.message}\x1B[0m");
    }

    buffer.writeln("\x1B[31m=========================================================\x1B[0m");

    developer.log(buffer.toString());
    handler.next(err);
  }
}
