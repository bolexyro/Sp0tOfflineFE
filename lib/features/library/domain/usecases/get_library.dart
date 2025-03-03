import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

class GetLibraryUseCase {
  GetLibraryUseCase(this._libraryRepository);

  final LibraryRepository _libraryRepository;

  Future<void> call() async {
    return await _libraryRepository.getLibrary();
  }
}
