import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

final class DioHelper {
  final _dio = Dio();

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
    } on DioException catch (dioException) {
      throw Exception('unexpected error');
    } on SocketException catch (e) {
      log('internet error: $e');
      throw Exception('No Internet Connection');
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
    } on DioException catch (dioException) {
      log('deo exception: $dioException');
      throw Exception('unexpected error');
    } on SocketException catch (e) {
      log('internet error: $e');
      throw Exception('No Internet Connection');
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
    } on DioException catch (dioException) {
      log('deo exception: $dioException');
      throw Exception('unexpected error');
    } on SocketException catch (e) {
      log('internet error: $e');
      throw Exception('No Internet Connection');
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
