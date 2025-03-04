import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

class GetPlaylistTracksUseCase {
  const GetPlaylistTracksUseCase(this._libraryRepository);
  final LibraryRepository _libraryRepository;

  Future<List<Track>> call(String playlistId) async {
    return _libraryRepository.getPlaylistTracks(playlistId);
  }
}
