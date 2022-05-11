import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({required this.id, required this.userName, required this.nickName});

  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "username")
  final String userName;
  @JsonKey(name: "nickname")
  final String nickName;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UsersModel {
  UsersModel({required this.users});

  List<UserModel> users;

  factory UsersModel.fromJson(Map<String, dynamic> data) => _$UsersModelFromJson(data);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
