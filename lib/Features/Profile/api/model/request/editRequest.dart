import 'package:json_annotation/json_annotation.dart';

part 'editRequest.g.dart';

@JsonSerializable()
class EditRequest {
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

  EditRequest ({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  factory EditRequest.fromJson(Map<String, dynamic> json) {
    return _$EditRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditRequestToJson(this);
  }
}

