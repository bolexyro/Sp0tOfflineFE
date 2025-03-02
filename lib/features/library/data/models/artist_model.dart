import 'package:json_annotation/json_annotation.dart';
part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel {
  final String id;
  final String name;

  ArtistModel({required this.id, required this.name});

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}
