import 'package:spotoffline/features/library/domain/entity/image.dart';

class Album {
  Album({required this.id, required this.name, required this.images});

  final String id;
  final String name;
  final List<Image> images;
}
