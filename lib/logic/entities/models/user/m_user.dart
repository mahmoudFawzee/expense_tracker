import 'package:expense_tracker/logic/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_user.g.dart';

@JsonSerializable()
final class UserModel extends User {
  const UserModel({
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
