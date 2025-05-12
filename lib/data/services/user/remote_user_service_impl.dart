import 'dart:developer';
import 'dart:io';
import 'package:expense_tracker/core/request/endpoints.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/helper/dio_helper.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/models/user/user_data_response.dart';
import 'package:expense_tracker/domain/services/user/i_remote_user_service.dart';

final class RemoteUserServiceImpl implements RemoteUserServiceInterface {
  final _dioHelper = DioHelper();
  @override
  Future<UserDataResponse> deleteUser({
    required String password,
    required String accessToken,
  }) async {
    {
      final response = await _dioHelper.delete(
        userEndPoint,
        headers: _dioHelper.getHeaders(accessToken),
      );
      return UserDataResponse(response);
    }
  }

  @override
  Future<UserDataResponse> getUser(String accessToken) async {
    final response = await _dioHelper.get(
      userEndPoint,
      headers: _dioHelper.getHeaders(accessToken),
    );
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      final data = response.data as Map<String, dynamic>;
      final map = data.remove(JsonKeys.id);
      final user = UserModel.fromJson(map);
      log('map: $map and user: $user');
      return UserDataResponse(user: user, response);
    }
    return UserDataResponse(response);
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
      headers: _dioHelper.getHeaders(accessToken),
      body: password == null ? user.toJson() : requestBody,
    );

    final statusCode = response.statusCode;
    final data = response.data as Map<String, dynamic>;
    log('update email  $data');
    //?instead of removing the id
    //?we just need to replace it with the given user id
    //?user given in the function as an attribute.
    //?the id we receive from the backend isn't
    //?the one in our local database.

    if (statusCode == HttpStatus.ok) {
      data['id'] = user.id;
      final formattedUser = UserModel.fromJson(data);
      return UserDataResponse(user: formattedUser, response);
    }

    return UserDataResponse(response);
  }

  @override
  Future<UserDataResponse> changePassword(
    accessToken, {
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final body = {
      JsonKeys.oldPassword: oldPassword,
      JsonKeys.newPassword: newPassword,
      JsonKeys.newPasswordConfirmation: confirmNewPassword,
    };
    final response = await _dioHelper.patch(
      changePasswordEndPoint,
      headers: _dioHelper.getHeaders(accessToken),
      body: body,
    );
    log('$response');
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return UserDataResponse(response);
    }

    return UserDataResponse(response);
  }
}
