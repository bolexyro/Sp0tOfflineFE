// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistModel _$PlaylistModelFromJson(Map<String, dynamic> json) =>
    PlaylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      ownerName: json['owner_name'] as String,
      totalTracks: (json['total_tracks'] as num).toInt(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistModelToJson(PlaylistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'owner_name': instance.ownerName,
      'total_tracks': instance.totalTracks,
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
