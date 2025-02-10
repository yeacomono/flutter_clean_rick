import 'package:clean_arch_rick_and_morty/src/core/network/error_interceptor.dart';
import 'package:clean_arch_rick_and_morty/src/core/network/loggin_interceptor.dart';
import 'package:clean_arch_rick_and_morty/src/core/network/token_interceptor.dart';
import 'package:dio/dio.dart';

class APIClient {
  final Dio _dio;

  APIClient(String url, {int timeoutMs = 5000})
      : _dio = Dio(
          BaseOptions(
            baseUrl: url,
            receiveTimeout: Duration(milliseconds: timeoutMs),
            validateStatus: (status) =>
                status != null && status >= 200 && status <= 500,
          ),
        ) {
    _dio.interceptors.addAll([
      LoggingInterceptor(),
      TokenInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Future<Response?> post(String endpoint, Map<String, dynamic>? data,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.post(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
  }

  Future<Response?> get(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.get(endpoint,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response?> put(String endpoint, Map<String, dynamic>? data,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.put(endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
  }

  Future<Response?> delete(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.delete(endpoint,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response?> patch(String endpoint, Map<String, dynamic>? data,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
