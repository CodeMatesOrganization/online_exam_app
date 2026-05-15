import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Profile/api/model/UserModelDto.dart';

part 'UserDataResponse.g.dart';

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserModelDto? user;

  UserDataResponse ({
    this.message,
    this.user,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return _$UserDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDataResponseToJson(this);
  }
}



