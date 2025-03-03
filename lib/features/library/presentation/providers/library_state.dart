import 'package:spotoffline/features/library/domain/entity/album.dart';
import 'package:spotoffline/features/library/domain/entity/playlist.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';

class LibraryState {
  LibraryState({
    required this.isLoading,
    required this.libraryAction,
    this.libraryData,
  });
  final bool isLoading;
  final LibraryAction libraryAction;
  final LibraryData? libraryData;
}

enum LibraryAction {
  fetchingLikedSongs,
  fetchingAlbums,
  fetchingPlaylists,
  idle,
  completed,
  failed;

  String get name {
    if (this == LibraryAction.fetchingAlbums) return 'Fetching Albums';
    if (this == LibraryAction.fetchingLikedSongs) return 'Fetching Liked Songs';
    if (this == LibraryAction.fetchingPlaylists) return 'Fetching Playlists';
    if (this == LibraryAction.failed) return 'Fetching your library failed';
    return 'Completed';
  }
}

class LibraryData {
  LibraryData({
    required this.likedSongs,
    required this.albums,
    required this.playlists,
  });
  final List<Track> likedSongs;
  final List<Album> albums;
  final List<Playlist> playlists;
}
