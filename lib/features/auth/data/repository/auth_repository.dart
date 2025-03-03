import 'package:spotoffline/core/auth/token_manager.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/di/service_locator.dart';
import 'package:spotoffline/core/extensions.dart';
import 'package:spotoffline/features/auth/data/data_sources/local_data_source.dart';
import 'package:spotoffline/features/auth/data/data_sources/websocket_data_source.dart';
import 'package:spotoffline/features/auth/data/models/auth_data_model.dart';
import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._websocketDataSource, this._localDataSource);

  final WebsocketDataSource _websocketDataSource;
  final LocalDataSource _localDataSource;

  @override
  Future<DataState<AuthData>> listenForAuthSuccess() async {
    final dataState = await _websocketDataSource.listenForAuthSuccess();
    if (dataState is DataSuccess) {
      final authData = dataState.data!;
      await _localDataSource.saveAuthData(authData);
      getIt<TokenManager>().accessToken = authData.token!.accessToken;
      getIt<TokenManager>().refreshToken = authData.token!.refreshToken;

      return DataSuccess(dataState.data!.toEntity());
    }
    return DataException(dataState.exceptionMessage!);
  }

  @override
  Future<void> logout() async {
    await _localDataSource.deleteAuthData();
  }

  @override
  DataState<AuthData> loadAuthData() {
    final authData = _localDataSource.getAuthData();
    if (authData == null) {
      return const DataException('No auth data found');
    }
    getIt<TokenManager>().accessToken = authData.token!.accessToken;
    getIt<TokenManager>().refreshToken = authData.token!.refreshToken;
    return DataSuccess(authData.toEntity());
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _localDataSource.saveAuthData(AuthDataModel(
        user: null, token: TokenModel(accessToken, refreshToken)));
  }
}
