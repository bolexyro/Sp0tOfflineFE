import 'package:json_annotation/json_annotation.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
part 'playlist_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistModel {
  PlaylistModel({required this.id, required this.name, required this.images});

  final String id;
  final String name;
  final List<ImageModel> images;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistModelToJson(this);
}
