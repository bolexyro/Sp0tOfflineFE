import 'package:dio/dio.dart';
import 'package:spotoffline/core/auth/token_manager.dart';
import 'package:spotoffline/core/di/service_locator.dart';
import 'package:spotoffline/core/network/api_endpoints.dart';
import 'package:spotoffline/core/network/dio_client.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._authManager);

  final TokenManager _authManager;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authManager.accessToken;
    options.headers["Authorization"] = "Bearer $token";
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("bolexyro nations ${err.response?.statusCode}");
    if (err.response?.statusCode == 401) {
      try {
        final response = await refreshToken();

        if (response.containsKey('access_token') &&
            response.containsKey('refresh_token')) {
          getIt<TokenManager>().accessToken = response["access_token"];
          getIt<TokenManager>().refreshToken = response["refresh_token"];
          final newToken = getIt<TokenManager>().accessToken;
          err.requestOptions.headers["Authorization"] = "Bearer $newToken";

          final newResponse =
              await getIt<DioClient>().dio.fetch(err.requestOptions);
          return handler.resolve(newResponse);
        } else {
          handler.next(err);
        }
      } catch (refreshError) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    final response = await getIt<DioClient>().dio.post(
        ApiEndpoints.refreshToken,
        data: {"refresh_token": getIt<TokenManager>().refreshToken});
    return response.data;
  }
}
