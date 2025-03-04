import 'package:spotoffline/features/library/domain/entity/artist.dart';
import 'package:spotoffline/features/library/domain/entity/image.dart';

class Album {
  Album({
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
  final String type;
  final int totalTracks;
  final String releaseDate;
  final List<Artist> artists;
  final List<Image> images;
}
