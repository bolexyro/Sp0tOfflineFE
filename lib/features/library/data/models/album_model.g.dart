// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) => AlbumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['album_type'] as String,
      totalTracks: (json['total_tracks'] as num).toInt(),
      releaseDate: json['release_date'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'album_type': instance.type,
      'total_tracks': instance.totalTracks,
      'release_date': instance.releaseDate,
      'artists': instance.artists.map((e) => e.toJson()).toList(),
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
