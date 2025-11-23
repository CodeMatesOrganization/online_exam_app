// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerResponseError _$ServerResponseErrorFromJson(Map<String, dynamic> json) =>
    ServerResponseError(
      code: json['code'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ServerResponseErrorToJson(
  ServerResponseError instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
