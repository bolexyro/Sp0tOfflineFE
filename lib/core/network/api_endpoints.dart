class ApiEndpoints {
  static const subDomain = 'lively-helpful-monarch.ngrok-free.app';
  static const baseUrl = 'https://$subDomain';
  static const login = '$baseUrl/login';
  static const likedSongs = '/liked-songs';
  static const refreshToken = '/auth/refresh-token';
  static const tokenWebsocket = 'wss://$subDomain/ws/token';
}
