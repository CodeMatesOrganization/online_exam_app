// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectsResponse _$SubjectsResponseFromJson(Map<String, dynamic> json) =>
    SubjectsResponse(
      message: json['message'] as String?,
      pagination: json['Pagination'] == null
          ? null
          : Pagination.fromJson(json['Pagination'] as Map<String, dynamic>),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubjectModelDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectsResponseToJson(SubjectsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'Pagination': instance.pagination,
      'subjects': instance.subjects,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['currentPage'] as num?)?.toInt(),
  numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
    };
