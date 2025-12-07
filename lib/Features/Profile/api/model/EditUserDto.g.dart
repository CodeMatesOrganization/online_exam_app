// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EditUserDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditUserDto _$EditUserDtoFromJson(Map<String, dynamic> json) => EditUserDto(
  message: json['message'] as String?,
  user: json['user'] == null
      ? null
      : UserModelDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EditUserDtoToJson(EditUserDto instance) =>
    <String, dynamic>{'message': instance.message, 'user': instance.user};
