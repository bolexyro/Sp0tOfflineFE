// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['display_name'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      email: json['email'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'display_name': instance.name,
      'images': instance.images,
      'email': instance.email,
    };
