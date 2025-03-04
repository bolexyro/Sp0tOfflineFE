import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

class GetLikedSongsUseCase {
  final LibraryRepository _libraryRepository;
  GetLikedSongsUseCase(this._libraryRepository);

  Future<List<Track>> call() async {
    return _libraryRepository.getLikedSongs();
  }
}
