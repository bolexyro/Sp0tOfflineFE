import 'package:json_annotation/json_annotation.dart';
import 'package:spotoffline/features/library/data/models/artist_model.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
part 'album_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AlbumModel {
  AlbumModel({
    required this.id,
    required this.name,
    required this.type,
    required this.totalTracks,
    required this.releaseDate,
    required this.artists,
    required this.images,
  });

  final String id;
  final String name;
  @JsonKey(name: 'album_type')
  final String type;
  final int totalTracks;
  final String releaseDate;
  final List<ArtistModel> artists;
  final List<ImageModel> images;

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
