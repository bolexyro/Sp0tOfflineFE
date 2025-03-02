// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      id: json['id'] as String,
      name: json['name'] as String,
      previewUrl: json['preview_url'] as String?,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: AlbumModel.fromJson(json['album'] as Map<String, dynamic>),
      durationMs: (json['duration_ms'] as num).toInt(),
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preview_url': instance.previewUrl,
      'artists': instance.artists,
      'album': instance.album,
      'duration_ms': instance.durationMs,
    };
