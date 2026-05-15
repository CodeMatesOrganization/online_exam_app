import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()

class ForgetPasswordResponse {
  final String message;
  final String info ;


  ForgetPasswordResponse({required this.message , required this.info });


  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseFromJson(json);
  }
}