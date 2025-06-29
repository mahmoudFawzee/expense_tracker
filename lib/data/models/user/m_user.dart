import 'package:expense_tracker/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:expense_tracker/data/constants/json_keys.dart';
part 'm_user.g.dart';

@JsonSerializable()
final class UserModel extends User {
  const UserModel({
    super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Map<String, dynamic> toSqlJson() => {JsonKeys.id: id, ...toJson()};

  @override
  String toString() {
    final user = {'id':id,...toJson()};
    return '$user';
  }
}
