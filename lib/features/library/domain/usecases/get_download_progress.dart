import 'package:spotoffline/features/library/domain/repository/library_repository.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class GetDownloadProgressUseCase {
  const GetDownloadProgressUseCase(this._libraryRepository);

  final LibraryRepository _libraryRepository;

  Stream<LibraryState> call() {
    return _libraryRepository.downloadProgressStream;
  }
}
