import 'dart:developer';
import 'dart:io';
import 'package:expense_tracker/core/request/endpoints.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/helper/dio_helper.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/responses/auth_response.dart';
import 'package:expense_tracker/domain/services/auth/i_auth.dart';
import 'package:dio/dio.dart';

final class AuthService implements AuthInterface {
  final _dioHelper = DioHelper();
  @override
  Future<AuthResponse> register(
    UserModel user, {
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _dioHelper.post(
      registerEndPoint,
      headers: _dioHelper.headers,
      body: {
        ...user.toJson(),
        JsonKeys.password: password,
        JsonKeys.passwordConfirmation: confirmPassword,
      },
    );
    return _handelAuthResponse(response);
  }

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final requestBody = {
      JsonKeys.email: email,
      JsonKeys.password: password,
    };

    final response = await _dioHelper.post(
      loginEndPoint,
      headers: _dioHelper.headers,
      body: requestBody,
    );
    return _handelAuthResponse(response);
  }

  @override
  Future<AuthResponse> logout(String accessToken) async {
    final response = await _dioHelper.delete(
      logoutEndPoint,
      headers: _dioHelper.getHeaders(accessToken),
    );
    return AuthResponse(response);
  }

  AuthResponse _handelAuthResponse(Response<dynamic> response) {
    final statusCode = response.statusCode;    
    log('handle auth response method: status code: $statusCode, body: ${response.data}');
    //?user created
    if (statusCode == HttpStatus.created) {
      final resBody = response.data;
      final user = UserModel.fromJson(resBody[JsonKeys.data]);
      return AuthResponse(response, user: user);
    }
    //?user login accepted
    if (statusCode == HttpStatus.ok) {
      final resBody = response.data;
      final responseUser = resBody[JsonKeys.user] as Map<String, dynamic>;
      log('response login user: $responseUser');
      responseUser.remove(JsonKeys.id);
      log('response login user without id: $responseUser');
      //?if we got everything works well.
      final user = UserModel.fromJson(responseUser);
      final accessToken = resBody[JsonKeys.accessToken];
      final tokenType = resBody[JsonKeys.accessTokenType];

      return AuthResponse(
        response,
        user: user,
        accessToken: accessToken,
        tokenType: tokenType,
      );
    }
    return AuthResponse(response);
  }
}
