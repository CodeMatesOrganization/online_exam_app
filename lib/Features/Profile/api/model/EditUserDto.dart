import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Profile/api/model/UserModelDto.dart';
import 'package:online_exam/Features/Profile/domain/model/EditProfileModel.dart';

part 'EditUserDto.g.dart';

@JsonSerializable()
class EditUserDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserModelDto? user;

  EditUserDto ({
    this.message,
    this.user,
  });

  factory EditUserDto.fromJson(Map<String, dynamic> json) {
    return _$EditUserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditUserDtoToJson(this);
  }

  EditProfileModel toUserModel() {
    return  EditProfileModel(
      message: message,
      user: user!.toUserModel()
    );
  }
}


