import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';

part 'CategoryResponse.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  CategoryResponse ({
    this.Id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryResponseToJson(this);
  }

  SubjectModel toSubjectModel() {
    return  SubjectModel(
        name: name,
        icon: icon,
        Id:Id,
        createdAt: createdAt
    );
  }
}


