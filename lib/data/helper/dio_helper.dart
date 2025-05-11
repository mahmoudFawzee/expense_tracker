import 'dart:convert';

import 'package:dio/dio.dart';

final class DioHelper {
  final _dio = Dio();
  Future<Response> post(
    String url, {
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
  }) async {
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
  }

  Future<Response> delete(
    String url, {
    required Map<String, dynamic> headers,
     Map<String, dynamic>? body,
  }) async {
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
  }


  Future<Response> patch(
    String url, {
    required Map<String, dynamic> headers,
    required Map<String, dynamic> body,
  }) async {
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
  }

  Future<Response> get(
    String url, {
    required Map<String, dynamic> headers,    
  }) async {
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
  }



}
