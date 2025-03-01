abstract class LibraryRepository {
  Future<void> getLikedSongs();
  Future<void> getAlbums();
  Future<void> getPlaylists();
}
