import 'package:spotoffline/features/library/domain/entity/album.dart';
import 'package:spotoffline/features/library/domain/entity/artist.dart';

class Track {
  Track({
    required this.id,
    required this.name,
    this.previewUrl,
    required this.artists,
    required this.album,
    required this.durationMs,
  });

  final String id;
  final String name;
  final String? previewUrl;
  final List<Artist> artists;
  final Album album;
  final int durationMs;

  String get artistsString => artists.map((artist)=>artist.name).join(", ");
}


