import 'package:json_annotation/json_annotation.dart';

part 'spotify_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Track {
  final String id;
  final String name;
  final String? previewUrl;
  final List<Artist> artists;
  final Album album;
  final int durationMs;

  Track({
    required this.id,
    required this.name,
    this.previewUrl,
    required this.artists,
    required this.album,
    required this.durationMs,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Artist {
  final String id;
  final String name;

  Artist({required this.id, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class Album {
  final String id;
  final String name;
  final List<SpotifyImage> images;

  Album({required this.id, required this.name, required this.images});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class SpotifyImage {
  final String url;
  final int height;
  final int width;

  SpotifyImage({required this.url, required this.height, required this.width});

  factory SpotifyImage.fromJson(Map<String, dynamic> json) => _$SpotifyImageFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyImageToJson(this);
}
