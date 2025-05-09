import 'dart:developer';
import 'dart:io';

import 'package:expense_tracker/app/request/endpoints.dart';
import 'package:expense_tracker/app/request/headers.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/exceptions/backend_validation_exceptions.dart';
import 'package:expense_tracker/data/helper/dio_helper.dart';
import 'package:expense_tracker/data/models/user/logged_in_user.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/services/auth/i_auth.dart';
import 'package:dio/dio.dart';

final class AuthService implements AuthInterface {
  final _dioHelper = DioHelper();
  @override
  Future register(
    UserModel user, {
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _dioHelper.post(
      registerEndPoint,
      headers: headers,
      body: {
        ...user.toJson(),
        JsonKeys.password: password,
        JsonKeys.passwordConfirmation: confirmPassword,
      },
    );
    return _handelAuthResponse(response);
  }

  @override
  Future login({
    required String email,
    required String password,
  }) async {
    final requestBody = {
      JsonKeys.email: email,
      JsonKeys.password: password,
    };

    final response = await _dioHelper.post(
      loginEndPoint,
      headers: headers,
      body: requestBody,
    );
    return _handelAuthResponse(response);
  }

  @override
  Future<bool> logout(String accessToken) async {
    final response = await _dioHelper.delete(
      logoutEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
    );
    return response.statusCode == HttpStatus.ok;
  }

  dynamic _handelAuthResponse(Response<dynamic> response) {
    final statusCode = response.statusCode;
    final responseData = response.data;
    log('handle auth response method: status code: $statusCode, body: $responseData');
    //?user created
    if (statusCode == HttpStatus.created) {
      return UserModel.fromJson(responseData[JsonKeys.data]);
    }
    //?user login accepted
    if (statusCode == HttpStatus.ok) {
      //?if we got everything works well.
      final user = UserModel.fromJson(responseData[JsonKeys.user]);
      final accessToken = responseData[JsonKeys.accessToken];
      final tokenType = responseData[JsonKeys.accessTokenType];

      return LoggedInUser(
        user: user,
        accessToken: accessToken,
        tokenType: tokenType,
      );
    }
    return ValidationExceptions(responseData);
  }
}
