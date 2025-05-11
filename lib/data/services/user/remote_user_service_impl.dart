import 'dart:developer';
import 'dart:io';

import 'package:expense_tracker/app/request/endpoints.dart';
import 'package:expense_tracker/app/request/headers.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/exceptions/exception.dart';
import 'package:expense_tracker/data/exceptions/response_exceptions.dart';
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
    {final response = await _dioHelper.delete(
      userEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
    );
    return response.statusCode == HttpStatus.ok;}
  }

  @override
  Future<UserDataResponse> getUser(String accessToken) async {
    final response = await _dioHelper.get(
      userEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
    );
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      final data = response.data as Map<String, dynamic>;
      final map = data.remove(JsonKeys.id);
      final user = UserModel.fromJson(map);
      log('map: $map and user: $user');
      return UserDataResponse(user: user);
    } else if (statusCode == HttpStatus.internalServerError) {
      throw const InternalServerException('Internal Server Error');
    }
    return UserDataResponse(exceptions: response.data[JsonKeys.errors]);
  }

  @override
  Future<UserDataResponse> updateUser(
    UserModel user, {
    required String accessToken,
    String? password,
  }) async {
    final requestBody = {
      JsonKeys.password: password,
      ...user.toJson(),
    };
    log('req body: $requestBody');
    final response = await _dioHelper.patch(
      userEndPoint,
      headers: {JsonKeys.authorization: accessToken, ...headers},
      body: password == null ? user.toJson() : requestBody,
    );

    final statusCode = response.statusCode;
    final data = response.data as Map<String, dynamic>;
    log('update email response: $data');
    //?instead of removing the id
    //?we just need to replace it with the given user id
    //?user given in the function as an attribute.
    //?the id we receive from the backend isn't
    //?the one in our local database.

    if (statusCode == HttpStatus.ok) {
      data['id'] = user.id;
      final formattedUser = UserModel.fromJson(data);
      return UserDataResponse(user: formattedUser);
    }

    return UserDataResponse(
      exceptions: ResponseExceptions(data[JsonKeys.errors]),
      message: data[JsonKeys.message],
    );
  }
}
