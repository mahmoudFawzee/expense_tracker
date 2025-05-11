import 'dart:developer';
import 'dart:io';

import 'package:expense_tracker/app/request/endpoints.dart';
import 'package:expense_tracker/app/request/headers.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/helper/dio_helper.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/models/user/user_data_response.dart';
import 'package:expense_tracker/domain/services/user/i_remote_user_service.dart';

final class RemoteUserServiceImpl implements RemoteUserServiceInterface {
  final _dioHelper = DioHelper();
  @override
  Future<bool> deleteUser({
    required String password,
    required String accessToken,
  }) async {
    final response = await _dioHelper.delete(
      userEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
    );
    return response.statusCode == HttpStatus.ok;
  }

  @override
  Future<UserDataResponse> getUser(String accessToken) async {
    final response = await _dioHelper.get(
      userEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
    );
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return UserDataResponse(user: UserModel.fromJson(response.data));
    }
    return UserDataResponse(exceptions: response.data[JsonKeys.errors]);
  }

  @override
  Future<UserDataResponse> updateUser(
    UserModel user, {
    required String accessToken,
    String? password,
  }) async {
    final response = await _dioHelper.patch(
      userEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
      body: user.toJson(),
    );

    final statusCode = response.statusCode;
    final resData = response.data;
    log('status code: $statusCode and body: $resData');

    if (statusCode == HttpStatus.ok) {
      return UserDataResponse(user: UserModel.fromJson(response.data));
    }

    return UserDataResponse(exceptions: resData[JsonKeys.errors]);
  }
}
