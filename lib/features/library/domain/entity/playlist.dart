import 'package:spotoffline/features/library/domain/entity/image.dart';

class Playlist {
  Playlist({
    required this.id,
    required this.description,
    required this.name,
    required this.ownerName,
    required this.images,
  });

  final String id;
  final String? description;
  final String name;
  final String ownerName;
  final List<Image> images;
}
