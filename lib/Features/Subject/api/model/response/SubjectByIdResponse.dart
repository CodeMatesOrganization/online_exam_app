import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Subject/api/model/response/CategoryResponse.dart';

part 'SubjectByIdResponse.g.dart';

@JsonSerializable()
class SubjectByIdResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "category")
  final CategoryResponse? category;

  SubjectByIdResponse ({
    this.message,
    this.category ,
  });

  factory SubjectByIdResponse.fromJson(Map<String, dynamic> json) {
    return _$SubjectByIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectByIdResponseToJson(this);
  }


}

