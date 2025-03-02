import 'package:dio/dio.dart';
import 'package:spotoffline/core/auth/auth_interceptor.dart';
import 'package:spotoffline/core/auth/token_manager.dart';
import 'package:spotoffline/core/di/service_locator.dart';
import 'package:spotoffline/core/network/api_endpoints.dart';

class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            // connectTimeout: const Duration(seconds: 30),
            // receiveTimeout: const Duration(seconds: 30),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ) {
    dio.interceptors.add(AuthInterceptor(getIt<TokenManager>()));
  }
  final Dio dio;
}
