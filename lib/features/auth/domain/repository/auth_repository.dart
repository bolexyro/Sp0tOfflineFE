import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';

abstract class AuthRepository {

  Future<DataState<AuthData>> listenForAuthSuccess();
  Future<void> logout();
  Future<void> refreshToken();
  // Future<AuthData? >
}
