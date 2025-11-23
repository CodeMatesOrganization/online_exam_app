import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Subject/api/model/SubjectModelDTO.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';

part 'SubjectsResponse.g.dart';

@JsonSerializable()
class SubjectsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "Pagination")
  final Pagination? pagination;
  @JsonKey(name: "subjects")
  final List<SubjectModelDto>? subjects;

  SubjectsResponse ({
    this.message,
    this.pagination,
    this.subjects,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return _$SubjectsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectsResponseToJson(this);
  }

}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "numberOfPages")
  final int? numberOfPages;
  @JsonKey(name: "limit")
  final int? limit;

  Pagination ({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationToJson(this);
  }

}
