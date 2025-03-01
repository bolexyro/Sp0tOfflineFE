import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/extensions.dart';
import 'package:spotoffline/features/auth/data/data_sources/local_data_source.dart';
import 'package:spotoffline/features/auth/data/data_sources/websocket_data_source.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.websocketDataSource, this.localDataSource);

  final WebsocketDataSource websocketDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<DataState<AuthData>> listenForAuthSuccess() async {
    final dataState = await websocketDataSource.listenForAuthSuccess();
    print(dataState);
    if (dataState is DataSuccess) {
      await localDataSource.saveAuthData(dataState.data!);
      return DataSuccess(dataState.data!.toEntity());
    }
    return DataException(dataState.exceptionMessage!);
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteAuthData();
  }

  @override
  Future<void> refreshToken() {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  DataState<AuthData> loadAuthData() {
    final authData = localDataSource.getAuthData();
    if (authData == null) {
      return const DataException('No auth data found');
    }
    return DataSuccess(authData.toEntity());
  }
}
