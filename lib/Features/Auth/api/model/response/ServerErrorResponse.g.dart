// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServerErrorResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerErrorResponse _$ServerErrorResponseFromJson(Map<String, dynamic> json) =>
    ServerErrorResponse(
      message: json['message'] as String?,
      statusMessage: json['statusMessage'] as String?,
    );

Map<String, dynamic> _$ServerErrorResponseToJson(
        ServerErrorResponse instance) =>
    <String, dynamic>{
      'statusMessage': instance.statusMessage,
      'message': instance.message,
    };
