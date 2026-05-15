import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';

class ExamResultModel {
  final String title;
  final int? correct;
  final int? wrong;
  final int totalQuestions;
  final DateTime date;

  final List<CorrectQuestions> correctQuestions;
  final List<WrongQuestions> wrongQuestions;

  /// NOTE → store JSON not model
  final List<dynamic> allQuestions;

  ExamResultModel({
    required this.title,
    required this.correct,
    required this.wrong,
    required this.totalQuestions,
    required this.date,
    required this.correctQuestions,
    required this.wrongQuestions,
    required this.allQuestions,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'correct': correct,
    'wrong': wrong,
    'totalQuestions': totalQuestions,
    'date': date.toIso8601String(),
    'correctQuestions':
    correctQuestions.map((e) => e.toJson()).toList(),
    'wrongQuestions':
    wrongQuestions.map((e) => e.toJson()).toList(),

    /// store raw JSON
    'allQuestions': allQuestions,
  };

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      ExamResultModel(
        title: json['title'],
        correct: json['correct'],
        wrong: json['wrong'],
        totalQuestions: json['totalQuestions'],
        date: DateTime.parse(json['date']),
        correctQuestions: (json['correctQuestions'] as List)
            .map((e) => CorrectQuestions.fromJson(e))
            .toList(),
        wrongQuestions: (json['wrongQuestions'] as List)
            .map((e) => WrongQuestions.fromJson(e))
            .toList(),

        /// load raw JSON
        allQuestions: json['allQuestions'] ?? [],
      );
}
