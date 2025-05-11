import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';

final class ResponseExceptions extends Equatable {
  final Map<String, dynamic>? _responseBody;
  const ResponseExceptions(Map<String, dynamic>? response)
      : _responseBody = response;

  String get message => _responseBody?[JsonKeys.message];
  Map<String, dynamic>? get errors => _responseBody?[JsonKeys.errors];
  @override
  List<Object?> get props => [_responseBody, message, errors];
}
