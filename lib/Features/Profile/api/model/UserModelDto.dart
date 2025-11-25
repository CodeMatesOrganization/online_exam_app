import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';

part 'UserModelDto.g.dart';

@JsonSerializable()
class UserModelDto {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "isVerified")
  final bool? isVerified;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserModelDto ({
    this.Id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
  });

  factory UserModelDto.fromJson(Map<String, dynamic> json) {
    return _$UserModelDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelDtoToJson(this);
  }
  UserModel toUserModel() {
    return  UserModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        isVerified: isVerified,
        role: role,
        username: username,
        Id: Id,
        createdAt: createdAt
    );
  }
}


