import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthAccessInfo {
  AuthAccessInfo(this.accessToken, this.tokenType);

  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "token_type")
  String tokenType;

  factory AuthAccessInfo.fromJson(Map<String, dynamic> json) => _$AuthAccessInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthAccessInfoToJson(this);
}