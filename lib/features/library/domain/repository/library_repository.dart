import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';

abstract class LibraryRepository {
  Future<DataState<List<Track>>> getLibrary();
}
