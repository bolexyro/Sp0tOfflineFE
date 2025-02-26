class AppConstants {}

class ApiEndpoints {
  static const subDomain = 'lively-helpful-monarch.ngrok-free.app';
  static const baseUrl = 'https://$subDomain';
  static const login = '$baseUrl/login';
  static const tokenWebsocket = 'wss://$subDomain/ws/token';
}
