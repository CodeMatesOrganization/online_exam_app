// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectModelDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModelDto _$SubjectModelDtoFromJson(Map<String, dynamic> json) =>
    SubjectModelDto(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$SubjectModelDtoToJson(SubjectModelDto instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
    };
