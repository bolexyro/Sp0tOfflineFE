import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

abstract class LibraryRepository {
  Future<void> getLibrary();
  Future<List<Track>> getLikedSongs();
  Future<List<Track>> getPlaylistTracks(String playlistId);
  Future<List<Track>> getAlbumTracks(String albumId);
  Stream<LibraryState> get downloadProgressStream;
}
