// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditRequest _$EditRequestFromJson(Map<String, dynamic> json) => EditRequest(
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$EditRequestToJson(EditRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
    };
