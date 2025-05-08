import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:expense_tracker/app/request/endpoints.dart';
import 'package:expense_tracker/app/request/headers.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/exceptions/backend_validation_exceptions.dart';
import 'package:expense_tracker/data/models/user/logged_in_user.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/services/auth/i_auth.dart';
import 'package:dio/dio.dart';

final class AuthService implements AuthInterface {
  final _dio = Dio();
  @override
  Future login({
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

    return _handelAuthResponse(response);
  }

  @override
  Future<bool> logout(String accessToken) async {
    final response = await _dio.request(
      logoutEndPoint,
      options: Options(
        method: 'DELETE',
        headers: {JsonKeys.authorization: accessToken, ...headers},
        responseType: ResponseType.json,
      ),
    );
    return response.statusCode == HttpStatus.ok;
  }

  @override
  Future register(
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
        validateStatus: (_) => true,
      ),
    );
    return _handelAuthResponse(response);
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
    // //?login or register errors.
    // if (statusCode == HttpStatus.unprocessableEntity) {
    //   //?now it may hold many errors=>Map<String,List<String>>
    //   //?now we can access the errors in our bloc
    //   //?just for each error we'll assign errors['field_name'].first;
    //   return ValidationExceptions(responseData);
    // }
    // //?now there is some unexpected error we will pass it now
    // return responseData[JsonKeys.message];
    return ValidationExceptions(responseData);
  }
}
