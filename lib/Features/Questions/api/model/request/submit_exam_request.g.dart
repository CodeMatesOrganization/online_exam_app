// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_exam_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitExamRequest _$SubmitExamRequestFromJson(Map<String, dynamic> json) =>
    SubmitExamRequest(
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answers.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: (json['time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubmitExamRequestToJson(SubmitExamRequest instance) =>
    <String, dynamic>{
      'answers': instance.answers?.map((e) => e.toJson()).toList(),
      'time': instance.time,
    };

Answers _$AnswersFromJson(Map<String, dynamic> json) => Answers(
      questionId: json['questionId'] as String?,
      correct: json['correct'] as String?,
    );

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'questionId': instance.questionId,
      'correct': instance.correct,
    };
