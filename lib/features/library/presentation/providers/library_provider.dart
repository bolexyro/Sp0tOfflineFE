import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/di/service_locator.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';
import 'package:spotoffline/features/library/domain/usecases/get_album_tracks.dart';
import 'package:spotoffline/features/library/domain/usecases/get_download_progress.dart';
import 'package:spotoffline/features/library/domain/usecases/get_library.dart';
import 'package:spotoffline/features/library/domain/usecases/get_liked_songs.dart';
import 'package:spotoffline/features/library/domain/usecases/get_playlist_tracks.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class LibraryNotifier extends StateNotifier<LibraryState> {
  LibraryNotifier(
    this._getLibraryUseCase,
    this._getDownloadProgressUseCase,
    this._getLikedSongsUseCase,
    this._getAlbumTracksUseCase,
    this._getPlaylistTracksUseCase,
  ) : super(
          LibraryState(
            isLoading: false,
            libraryAction: LibraryAction.idle,
          ),
        );

  final GetLibraryUseCase _getLibraryUseCase;
  final GetDownloadProgressUseCase _getDownloadProgressUseCase;
  final GetLikedSongsUseCase _getLikedSongsUseCase;
  final GetAlbumTracksUseCase _getAlbumTracksUseCase;
  final GetPlaylistTracksUseCase _getPlaylistTracksUseCase;

  Future<void> getLibrary() async {
    state = LibraryState(
        isLoading: true, libraryAction: LibraryAction.idle, libraryData: null);
    _getDownloadProgressUseCase().listen((currentLibraryState) {
      state = currentLibraryState;
    });

    await _getLibraryUseCase();
  }

  Future<List<Track>> getLikedSongs() async {
    return await _getLikedSongsUseCase();
  }

  Future<List<Track>> getAlbumTracks(String albumId) async {
    return await _getAlbumTracksUseCase(albumId);
  }

  Future<List<Track>> getPlaylistTracks(String playlistId) async {
    return await _getPlaylistTracksUseCase(playlistId);
  }
}

final libraryProvider = StateNotifierProvider<LibraryNotifier, LibraryState>(
  (ref) => LibraryNotifier(
    GetLibraryUseCase(getIt<LibraryRepository>()),
    GetDownloadProgressUseCase(getIt<LibraryRepository>()),
    GetLikedSongsUseCase(getIt()),
    GetAlbumTracksUseCase(getIt()),
    GetPlaylistTracksUseCase(getIt()),
  ),
);
