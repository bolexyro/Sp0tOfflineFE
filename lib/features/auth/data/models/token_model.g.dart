// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenFromJson(Map<String, dynamic> json) => TokenModel(
      json['access_token'] as String,
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$TokenToJson(TokenModel instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
