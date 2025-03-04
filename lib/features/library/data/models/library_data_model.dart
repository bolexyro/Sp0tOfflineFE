import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/playlist_model.dart';

class LibraryDataModel {
  LibraryDataModel({
    required this.totalLikedSongs,
    required this.albums,
    required this.playlists,
  });
  // if this is non null then there are likedsongs
  final int? totalLikedSongs;
  final List<AlbumModel> albums;
  final List<PlaylistModel> playlists;
}
