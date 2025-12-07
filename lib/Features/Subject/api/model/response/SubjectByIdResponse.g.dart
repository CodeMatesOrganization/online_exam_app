// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectByIdResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectByIdResponse _$SubjectByIdResponseFromJson(Map<String, dynamic> json) =>
    SubjectByIdResponse(
      message: json['message'] as String?,
      category: json['category'] == null
          ? null
          : CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubjectByIdResponseToJson(
        SubjectByIdResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'category': instance.category,
    };
