import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

class GetAlbumTracksUseCase {
  const GetAlbumTracksUseCase(this._libraryRepository);
  final LibraryRepository _libraryRepository;

  Future<List<Track>> call(String albumId) async {
    return _libraryRepository.getAlbumTracks(albumId);
  }
}
