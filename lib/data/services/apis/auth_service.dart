import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:expense_tracker/app/request/endpoints.dart';
import 'package:expense_tracker/app/request/headers.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/services/auth/i_auth.dart';
import 'package:dio/dio.dart';

final class AuthService implements AuthInterface {
  final _dio = Dio();
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final requestBody = {
      "email": email,
      "password": password,
    };
    log('login end point: $loginEndPoint');
    final response = await _dio.request(
      loginEndPoint,
      data: json.encode(requestBody),
      options: Options(
        method: 'POST',
        headers: headers,
        responseType: ResponseType.json,
      ),
    );
    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<bool> logout() async {
    final response = await _dio.request(
      logoutEndPoint,
      options: Options(
        method: 'DELETE',
        headers: headers,
        responseType: ResponseType.json,
      ),
    );
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) return true;
    return false;
  }

  @override
  Future<UserModel> register(
    UserModel user, {
    required String password,
    required String confirmPassword,
  }) async {
    log('register end point: $registerEndPoint');
    final response = await _dio.request(
      registerEndPoint,
      data: json.encode({
        ...user.toJson(),
        "password": password,
        "password_confirmation": confirmPassword,
      }),
      options: Options(
        method: 'POST',
        headers: headers,
        responseType: ResponseType.json,
      ),
    );
    final statusCode = response.statusCode;

    final data = response.data['data'];
    log('date: ${response.data["data"]} status code: $statusCode');
    return UserModel.fromJson(data);
  }
}
