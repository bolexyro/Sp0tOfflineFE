import 'dart:async';

import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/extensions.dart';
import 'package:spotoffline/features/library/data/data_source/remote_data_source.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  LibraryRepositoryImpl(this._remoteDataSource);

  final RemoteDataSource _remoteDataSource;

  final StreamController<LibraryState> _downloadProgressController =
      StreamController.broadcast();

  @override
  Future<void> getLibrary() async {
    _downloadProgressController.add(LibraryState(
        isLoading: true, libraryAction: LibraryAction.fetchingLikedSongs));

    final getLikedSongsDataState = await _remoteDataSource.getLikedSongs();
    if (getLikedSongsDataState is DataException) {
      _downloadProgressController.add(
          LibraryState(isLoading: false, libraryAction: LibraryAction.failed));
      return;
    }
    final likedSongs = getLikedSongsDataState.data!
        .map((trackModel) => trackModel.toEntity())
        .toList();

    _downloadProgressController.add(LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingAlbums,
        libraryData:
            LibraryData(likedSongs: likedSongs, albums: [], playlists: [])));

    final getAlbumsDataState = await _remoteDataSource.getAlbums();

    if (getAlbumsDataState is DataException) {
      _downloadProgressController.add(
          LibraryState(isLoading: false, libraryAction: LibraryAction.failed));
      return;
    }
    final albums = getAlbumsDataState.data!
        .map((albumModel) => albumModel.toEntity())
        .toList();
    _downloadProgressController.add(LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingAlbums,
        libraryData: LibraryData(
            likedSongs: likedSongs, albums: albums, playlists: [])));

    for (final album in getAlbumsDataState.data!) {
      final albumTrackDataState = await _remoteDataSource.getAlbumTracks(album);
      if (albumTrackDataState is DataException) {
        _downloadProgressController.add(LibraryState(
            isLoading: false, libraryAction: LibraryAction.failed));
        return;
      }
    }

    _downloadProgressController.add(LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingPlaylists,
        libraryData: LibraryData(
            likedSongs: likedSongs, albums: albums, playlists: [])));

    final getPlaylistsDataState = await _remoteDataSource.getPlaylists();
    if (getPlaylistsDataState is DataException) {
      _downloadProgressController.add(
          LibraryState(isLoading: false, libraryAction: LibraryAction.failed));
      return;
    }
    final playlists = getPlaylistsDataState.data!
        .map((playlistModel) => playlistModel.toEntity())
        .toList();
    _downloadProgressController.add(LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingPlaylists,
        libraryData: LibraryData(
            likedSongs: likedSongs, albums: albums, playlists: playlists)));

    for (final playlist in getPlaylistsDataState.data!) {
      final playlistTrackDataState =
          await _remoteDataSource.getPlaylistTracks(playlist.id);
      if (playlistTrackDataState is DataException) {
        _downloadProgressController.add(LibraryState(
            isLoading: false, libraryAction: LibraryAction.failed));
        return;
      }
    }

    _downloadProgressController.add(LibraryState(
        isLoading: false,
        libraryAction: LibraryAction.completed,
        libraryData: LibraryData(
            likedSongs: likedSongs, albums: albums, playlists: playlists)));
  }

  @override
  Stream<LibraryState> get downloadProgressStream =>
      _downloadProgressController.stream;
}
