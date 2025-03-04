import 'dart:async';

import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/extensions.dart';
import 'package:spotoffline/features/library/data/data_source/local_data_source.dart';
import 'package:spotoffline/features/library/data/data_source/remote_data_source.dart';
import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/playlist_model.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  LibraryRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  final StreamController<LibraryState> _downloadProgressController =
      StreamController.broadcast();

  @override
  Future<void> getLibrary() async {
    _downloadProgressController.add(LibraryState(
      isOffline: true,
      isLoading: true,
      libraryAction: LibraryAction.completed,
    ));
    final libraryData = await _localDataSource.getLibrary();
    if (libraryData.albums.isNotEmpty ||
        libraryData.playlists.isNotEmpty ||
        libraryData.totalLikedSongs != 0) {
      _downloadProgressController.add(LibraryState(
        isOffline: true,
        isLoading: true,
        libraryAction: LibraryAction.completed,
        libraryData: libraryData.toEntity(),
      ));
      return;
    }

    _downloadProgressController.add(LibraryState(
        isLoading: true, libraryAction: LibraryAction.fetchingLikedSongs));

    final getLikedSongsDataState = await _remoteDataSource.getLikedSongs();
    if (getLikedSongsDataState is DataException) {
      _downloadProgressController.add(
          LibraryState(isLoading: false, libraryAction: LibraryAction.failed));
      return;
    }

    await _localDataSource.insertLikedSongTracks(getLikedSongsDataState.data!);
    final likedSongs = getLikedSongsDataState.data!
        .map((trackModel) => trackModel.toEntity())
        .toList();

    _downloadProgressController.add(LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingAlbums,
        libraryData: LibraryData(
            totalLikedSongs: likedSongs.length, albums: [], playlists: [])));

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
            totalLikedSongs: likedSongs.length, albums: [], playlists: [])));

    final fetchedAlbums = <AlbumModel>[];
    for (final album in getAlbumsDataState.data!) {
      final albumTrackDataState = await _remoteDataSource.getAlbumTracks(album);
      if (albumTrackDataState is DataException) {
        _downloadProgressController.add(LibraryState(
            isLoading: false, libraryAction: LibraryAction.failed));
        return;
      }
      await _localDataSource.insertAlbum(album, true);
      await _localDataSource.insertAlbumTracks(
          albumTrackDataState.data!, album);
      fetchedAlbums.add(album);
      _downloadProgressController.add(
        LibraryState(
          isLoading: true,
          libraryAction: LibraryAction.fetchingAlbums,
          libraryData: LibraryData(
            totalLikedSongs: likedSongs.length,
            albums: fetchedAlbums
                .map((albumModel) => albumModel.toEntity())
                .toList(),
            playlists: [],
          ),
        ),
      );
    }

    _downloadProgressController.add(
      LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingPlaylists,
        libraryData: LibraryData(
          totalLikedSongs: likedSongs.length,
          albums: albums,
          playlists: [],
        ),
      ),
    );

    final getPlaylistsDataState = await _remoteDataSource.getPlaylists();
    if (getPlaylistsDataState is DataException) {
      _downloadProgressController.add(
          LibraryState(isLoading: false, libraryAction: LibraryAction.failed));
      return;
    }

    final fetchedPlaylists = <PlaylistModel>[];
    final playlists = getPlaylistsDataState.data!
        .map((playlistModel) => playlistModel.toEntity())
        .toList();
    _downloadProgressController.add(
      LibraryState(
        isLoading: true,
        libraryAction: LibraryAction.fetchingPlaylists,
        libraryData: LibraryData(
          totalLikedSongs: likedSongs.length,
          albums: albums,
          playlists: [],
        ),
      ),
    );

    for (final playlist in getPlaylistsDataState.data!) {
      final playlistTrackDataState =
          await _remoteDataSource.getPlaylistTracks(playlist.id);
      if (playlistTrackDataState is DataException) {
        _downloadProgressController.add(LibraryState(
            isLoading: false, libraryAction: LibraryAction.failed));
        return;
      }
      _localDataSource.insertPlaylist(playlist);
      _localDataSource.insertPlaylistTracks(
          playlistTrackDataState.data!, playlist);
      fetchedPlaylists.add(playlist);
      _downloadProgressController.add(
        LibraryState(
          isLoading: true,
          libraryAction: LibraryAction.fetchingPlaylists,
          libraryData: LibraryData(
            totalLikedSongs: likedSongs.length,
            albums: albums,
            playlists: fetchedPlaylists
                .map((playlistModel) => playlistModel.toEntity())
                .toList(),
          ),
        ),
      );
    }

    _downloadProgressController.add(
      LibraryState(
        isLoading: false,
        libraryAction: LibraryAction.completed,
        libraryData: LibraryData(
          totalLikedSongs: likedSongs.length,
          albums: albums,
          playlists: playlists,
        ),
      ),
    );
  }

  @override
  Stream<LibraryState> get downloadProgressStream =>
      _downloadProgressController.stream;

  @override
  Future<List<Track>> getLikedSongs() async {
    return (await _localDataSource.getLikedSongs())
        .map((trackModel) => trackModel.toEntity())
        .toList();
  }

  @override
  Future<List<Track>> getAlbumTracks(String albumId) async {
    return (await _localDataSource.getAlbumTracks(albumId))
        .map((trackModel) => trackModel.toEntity())
        .toList();
  }

  @override
  Future<List<Track>> getPlaylistTracks(String playlistId) async {
    return (await _localDataSource.getPlaylistTracks(playlistId))
        .map((trackModel) => trackModel.toEntity())
        .toList();
  }
}
