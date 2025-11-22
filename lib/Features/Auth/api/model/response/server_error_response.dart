import 'package:json_annotation/json_annotation.dart';

part 'server_error_response.g.dart';

@JsonSerializable()
class ServerResponseError {
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "message")
  final String? message;

  ServerResponseError ({
    this.code,
    this.message,
  });

  factory ServerResponseError.fromJson(Map<String, dynamic> json) {
    return _$ServerResponseErrorFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServerResponseErrorToJson(this);
  }
}


