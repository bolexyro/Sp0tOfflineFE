import 'package:json_annotation/json_annotation.dart';
import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/artist_model.dart';

part 'track_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrackModel {
  final String id;
  final String name;
  final String? previewUrl;
  final List<ArtistModel> artists;
  final AlbumModel album;
  final int durationMs;

  TrackModel({
    required this.id,
    required this.name,
    this.previewUrl,
    required this.artists,
    required this.album,
    required this.durationMs,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) => _$TrackModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrackModelToJson(this);
}
