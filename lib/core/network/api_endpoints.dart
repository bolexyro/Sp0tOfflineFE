class ApiEndpoints {
  static const subDomain = 'lively-helpful-monarch.ngrok-free.app';
  static const baseUrl = 'https://$subDomain';
  static const login = '$baseUrl/login';
  static const likedSongs = '/liked-songs';
  static const albums = '/albums';
  static String albumTracks(String albumId) => '/albums/$albumId/tracks';
  static const playlists = '/playlists';
  static String playlistTracks(String playlistId) =>
      '/playlists/$playlistId/tracks';
  static const refreshToken = '/auth/refresh-token';
  static String tokenWebsocket(String id) => 'wss://$subDomain/ws/token/$id';
}
