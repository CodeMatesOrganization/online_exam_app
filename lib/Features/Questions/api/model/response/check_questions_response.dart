import 'package:json_annotation/json_annotation.dart';
part 'check_questions_response.g.dart';

@JsonSerializable()
class CheckQuestionsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "correct")
  final int? correct;
  @JsonKey(name: "wrong")
  final int? wrong;
  @JsonKey(name: "total")
  final String? total;
  @JsonKey(name: "WrongQuestions")
  final List<WrongQuestions>? wrongQuestions;
  @JsonKey(name: "correctQuestions")
  final List<CorrectQuestions>? correctQuestions;

  CheckQuestionsResponse({
    this.message,
    this.correct,
    this.wrong,
    this.total,
    this.wrongQuestions,
    this.correctQuestions,
  });

  factory CheckQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckQuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckQuestionsResponseToJson(this);
}

@JsonSerializable()
class WrongQuestions {
  @JsonKey(name: "QID")
  final String? QID;
  @JsonKey(name: "Question")
  final String? Question;
  @JsonKey(name: "inCorrectAnswer")
  final String? inCorrectAnswer;
  @JsonKey(name: "correctAnswer")
  final String? correctAnswer;

  @JsonKey(
    name: "answers",
    fromJson: _answersFromJson,
    toJson: _answersToJson,
  )
  final List<Answers> answers;

  WrongQuestions({
    this.QID,
    this.Question,
    this.inCorrectAnswer,
    this.correctAnswer,
    required this.answers,
  });

  factory WrongQuestions.fromJson(Map<String, dynamic> json) =>
      _$WrongQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$WrongQuestionsToJson(this);

  // parsing helper
  static List<Answers> _answersFromJson(dynamic json) {
    if (json is List) {
      return json.map((e) => Answers.fromJson(e)).toList();
    } else if (json is Map) {
      // empty object {}
      return [];
    }
    return [];
  }

  static dynamic _answersToJson(List<Answers> answers) =>
      answers.map((e) => e.toJson()).toList();
}

@JsonSerializable()
class CorrectQuestions {
  @JsonKey(name: "QID")
  final String? QID;
  @JsonKey(name: "Question")
  final String? Question;
  @JsonKey(name: "correctAnswer")
  final String? correctAnswer;

  @JsonKey(
    name: "answers",
    fromJson: WrongQuestions._answersFromJson,
    toJson: WrongQuestions._answersToJson,
  )
  final List<Answers> answers;

  CorrectQuestions({
    this.QID,
    this.Question,
    this.correctAnswer,
    required this.answers,
  });

  factory CorrectQuestions.fromJson(Map<String, dynamic> json) =>
      _$CorrectQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectQuestionsToJson(this);
}

@JsonSerializable()
class Answers {
  @JsonKey(name: "Answer")
  final String? answer;

  @JsonKey(
    name: "Correct",
    fromJson: _fromJsonCorrect,
  )
  final bool? correct;

  Answers({this.answer, this.correct});

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);

  static bool? _fromJsonCorrect(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) return value == "1";
    if (value is int) return value == 1;
    return null;
  }
}
