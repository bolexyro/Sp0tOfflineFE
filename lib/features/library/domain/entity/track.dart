import 'package:spotoffline/features/library/domain/entity/album.dart';
import 'package:spotoffline/features/library/domain/entity/artist.dart';

class Track {
  Track({
    required this.id,
    required this.name,
    this.previewUrl,
    this.lyrics,
    required this.artists,
    required this.album,
    required this.durationMs,
  });

  final String id;
  final String name;
  final String? previewUrl;
  final String? lyrics;
  final List<Artist> artists;
  final Album album;
  final int durationMs;

  String get artistsString => artists.map((artist) => artist.name).join(", ");

  Track copyWith({
    String? id,
    String? name,
    String? previewUrl,
    String? lyrics,
    List<Artist>? artists,
    Album? album,
    int? durationMs,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
      previewUrl: previewUrl ?? this.previewUrl,
      lyrics: lyrics ?? this.lyrics,
      artists: artists ?? this.artists,
      album: album ?? this.album,
      durationMs: durationMs ?? this.durationMs,
    );
  }
}
