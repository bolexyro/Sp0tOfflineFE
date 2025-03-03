import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

abstract class LibraryRepository {
  Future<void> getLibrary();
  // Future<DataState<List<Track>>> getLibrary();
  Stream<LibraryState> get downloadProgressStream;
}
