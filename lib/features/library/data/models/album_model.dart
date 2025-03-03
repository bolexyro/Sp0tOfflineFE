import 'package:json_annotation/json_annotation.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
part 'album_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumModel {
  final String id;
  final String name;
  final List<ImageModel> images;

  AlbumModel({required this.id, required this.name, required this.images});

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
