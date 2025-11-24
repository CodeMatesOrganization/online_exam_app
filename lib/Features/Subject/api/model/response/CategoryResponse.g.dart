// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
    };
