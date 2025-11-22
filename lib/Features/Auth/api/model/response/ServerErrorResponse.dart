import 'package:json_annotation/json_annotation.dart';

part 'ServerErrorResponse.g.dart';

@JsonSerializable()
class ServerErrorResponse{

  String? statusMessage;
  String? message;

  ServerErrorResponse({this.message,this.statusMessage});

  factory ServerErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$ServerErrorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServerErrorResponseToJson(this);
  }

}