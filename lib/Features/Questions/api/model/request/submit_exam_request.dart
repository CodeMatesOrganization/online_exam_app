import 'package:json_annotation/json_annotation.dart';

part 'submit_exam_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SubmitExamRequest {
  @JsonKey(name: "answers")
  final List<Answers>? answers;

  @JsonKey(name: "time")
  final int? time;

  SubmitExamRequest({
    this.answers,
    this.time,
  });

  factory SubmitExamRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitExamRequestFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      if (answers != null)
        "answers": answers!.map((e) => e.toJson()).toList(),
      if (time != null) "time": time,
    };
  }
}

@JsonSerializable()
class Answers {
  @JsonKey(name: "questionId")
  final String? questionId;

  @JsonKey(name: "correct")
  final String? correct;

  Answers({
    this.questionId,
    this.correct,
  });

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      "questionId": questionId,
    };

    if (correct != null && correct!.isNotEmpty) {
      json["correct"] = correct;
    }

    return json;
  }
}
