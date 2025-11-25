// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDataResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserModelDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{'message': instance.message, 'user': instance.user};
