import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam/Features/Subject/api/model/ExamModelDto.dart';

part 'ExamsRseponse.g.dart';

@JsonSerializable()
class ExamsRseponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Pagination? metadata;
  @JsonKey(name: "exams")
  final List<ExamModelDto>? exams;

  ExamsRseponse ({
    this.message,
    this.metadata,
    this.exams,
  });

  factory ExamsRseponse.fromJson(Map<String, dynamic> json) {
    return _$ExamsRseponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamsRseponseToJson(this);
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

