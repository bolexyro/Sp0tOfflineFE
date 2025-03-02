import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

class GetLibraryUseCase {
  GetLibraryUseCase(this._libraryRepository);

  final LibraryRepository _libraryRepository;

  Future<DataState<List<Track>>> call() async {
    return await _libraryRepository.getLibrary();
  }
}
