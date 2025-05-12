import 'package:dio/dio.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';

class BaseResponse {
  final Response _response;
  const BaseResponse(Response response) : _response = response;

  String? get message =>
      _exceptions != null ? null : _message ?? 'Unexpected Error';

  Map<String, dynamic>? get errors => _exceptions; //Map<String,List>

  Map<String, dynamic>? get _exceptions => _responseBody?[JsonKeys.errors];

  String? get _message => _responseBody[JsonKeys.message];

  get _responseBody => _response.data;

  int? get statusCode => _response.statusCode;
}
