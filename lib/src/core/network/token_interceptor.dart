import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const token = "token_simulado"; // Token simulado
    options.headers["Authorization"] = "Bearer $token";

    final buffer = StringBuffer();
    buffer.writeln(
        "\x1B[33m🔑 ===================== AUTH HEADER =====================\x1B[0m");
    buffer.writeln(
        "\x1B[33m🔑 Adding Authorization Header: Bearer $token\x1B[0m");
    buffer.writeln("\x1B[33m🔑 URL: ${options.uri}\x1B[0m");
    buffer.writeln("\x1B[33m🔑 METHOD: ${options.method}\x1B[0m");
    buffer.writeln("\x1B[33m🔑 HEADERS: ${options.headers}\x1B[0m");
    buffer.writeln(
        "\x1B[33m=========================================================\x1B[0m");

    developer.log(buffer.toString());
    handler.next(options);
  }
}
