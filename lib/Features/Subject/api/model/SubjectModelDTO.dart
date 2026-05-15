import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';

part 'SubjectModelDTO.g.dart';

@JsonSerializable()
class SubjectModelDto {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  SubjectModelDto ({
    this.Id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory SubjectModelDto.fromJson(Map<String, dynamic> json) {
    return _$SubjectModelDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectModelDtoToJson(this);
  }

  SubjectModel toSubjectModels() {
    return  SubjectModel(
      name: name,
      icon: icon,
      Id: Id,
      createdAt: createdAt
    );
  }
}


