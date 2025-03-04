import 'package:json_annotation/json_annotation.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
part 'playlist_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PlaylistModel {
  PlaylistModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerName,
    required this.totalTracks,
    required this.images,
  });

  final String id;
  @JsonKey(name: 'name')
  final String name;
  final String? description;
  final String ownerName;
  final int totalTracks;
  final List<ImageModel> images;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistModelToJson(this);
}
