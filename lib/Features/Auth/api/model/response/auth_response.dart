import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Auth/api/model/response/user_response.dart' show UserResponse;
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final UserResponse? user;

  AuthResponse ({
    this.message,
    this.token,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResponseToJson(this);
  }


  AuthResponseModel toAuthResponseModel(){
    return AuthResponseModel(
       user: user!.toUserModel(),
      message: message,
      token: token
    );
  }
}
