import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';

final class DioHelper {
  final _dio = Dio();

  Map<String, dynamic> getHeaders(String accessToken) {
    return {
      JsonKeys.authorization: accessToken,
      ...headers,
    };
  }

  static const _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  Map<String, dynamic> get headers => _headers;

  Future<Response> post(
    String url, {
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: json.encode(body),
        options: Options(
          method: 'POST',
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      );
      return response;
    } on DioException catch (e) {
      log('deo exception message: ${e.message}');
      log('deo exception error: ${e.error}');
      String errorMessage = _handelExceptionsMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    required Map<String, dynamic> headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: json.encode(body),
        options: Options(
          method: 'DELETE',
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      );
      return response;
    } on DioException catch (e) {
      log('deo exception message: ${e.message}');
      log('deo exception error: ${e.error}');
      String errorMessage = _handelExceptionsMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(
    String url, {
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: json.encode(body),
        options: Options(
          method: 'PATCH',
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      );
      return response;
    } on DioException catch (e) {
      log('deo exception message: ${e.message}');
      log('deo exception error: ${e.error}');
      String errorMessage = _handelExceptionsMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(
    String url, {
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await _dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (_) => true,
        ),
      );
      return response;
    } on DioException catch (e) {
      log('deo exception message: ${e.message}');
      log('deo exception error: ${e.error}');
      String errorMessage = _handelExceptionsMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  String _handelExceptionsMessage(DioException e) {
    if ((e.error.toString()).contains('Connection refused')) {
      return 'Server In Maintenance Now';
    }
    if ((e.error.toString()).contains('No route to host')) {
      return 'Server In Maintenance Now';
    }
    if ((e.error.toString()).contains('Network is unreachable')) {
      return 'No Internet Connection';
    }
    return 'Unexpected Error';
  }
}
