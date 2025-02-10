import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln(_colorize("➡️ ======================= REQUEST =======================", "blue"));
    buffer.writeln(_colorize("➡️ METHOD: ${options.method}", "blue"));
    buffer.writeln(_colorize("➡️ URL: ${options.uri}", "blue"));

    final formattedHeaders = _formatJson(options.headers);
    buffer.writeln(_colorize("➡️ HEADERS: $formattedHeaders", "blue"));

    if (options.data != null) {
      final formattedData = _formatJson(options.data);
      buffer.writeln(_colorize("➡️ BODY: $formattedData", "blue"));
    }

    buffer.writeln(_colorize("=========================================================", "blue"));
    developer.log(buffer.toString());

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln(_colorize("✅ ====================== RESPONSE =======================", "green"));
    buffer.writeln(_colorize("✅ STATUS: ${response.statusCode}", "green"));
    buffer.writeln(_colorize("✅ URL: ${response.requestOptions.uri}", "green"));

    final formattedHeaders = _formatJson(response.headers.map);
    buffer.writeln(_colorize("✅ HEADERS: $formattedHeaders", "green"));

    if (response.data != null) {
      final formattedData = _formatJson(response.data);
      buffer.writeln(_colorize("✅ DATA: $formattedData", "green"));
    }

    buffer.writeln(_colorize("=========================================================", "green"));
    developer.log(buffer.toString());

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln(_colorize("❌ ====================== ERROR =========================", "red"));
    buffer.writeln(_colorize("❌ STATUS: ${err.response?.statusCode ?? 'Unknown'}", "red"));
    buffer.writeln(_colorize("❌ URL: ${err.requestOptions.uri}", "red"));
    buffer.writeln(_colorize("❌ MESSAGE: ${err.message}", "red"));

    if (err.response?.headers != null) {
      final formattedHeaders = _formatJson(err.response!.headers.map);
      buffer.writeln(_colorize("❌ HEADERS: $formattedHeaders", "red"));
    }

    if (err.response?.data != null) {
      final formattedData = _formatJson(err.response?.data);
      buffer.writeln(_colorize("❌ ERROR DATA: $formattedData", "red"));
    }

    buffer.writeln(_colorize("=========================================================", "red"));
    developer.log(buffer.toString());

    handler.next(err);
  }

  /// 🔥 **Método para Formatear JSON Bonito**
  String _formatJson(dynamic data) {
    try {
      final jsonObject = json.decode(jsonEncode(data)); // Convierte el dato en JSON válido
      return const JsonEncoder.withIndent('  ').convert(jsonObject); // Formatea con espacios
    } catch (e) {
      return data.toString(); // Si no es JSON, devolver como String normal
    }
  }

  /// 🎨 **Método para Aplicar Colores a Cada Línea**
  String _colorize(String text, String color) {
    final colors = {
      "red": "\x1B[31m",
      "green": "\x1B[32m",
      "yellow": "\x1B[33m",
      "blue": "\x1B[34m",
      "magenta": "\x1B[35m",
      "cyan": "\x1B[36m",
      "reset": "\x1B[0m",
    };
    return "${colors[color] ?? colors['reset']}$text${colors['reset']}";
  }
}
