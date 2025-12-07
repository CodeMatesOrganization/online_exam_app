import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';

part 'ExamModelDto.g.dart';

@JsonSerializable()
class ExamModelDto {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "subject")
  final String? subject;
  @JsonKey(name: "numberOfQuestions")
  final int? numberOfQuestions;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  ExamModelDto ({
    this.Id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamModelDto.fromJson(Map<String, dynamic> json) {
    return _$ExamModelDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamModelDtoToJson(this);
  }
  ExamModel toExamModels() {
    return  ExamModel(
        Id: Id,
        title: title,
        duration: duration,
        active: active,
        createdAt: createdAt
    );
  }
}


