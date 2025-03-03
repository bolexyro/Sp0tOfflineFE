import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';
import 'package:spotoffline/features/auth/domain/usecases/listen_for_auth_success.dart';
import 'package:spotoffline/features/auth/domain/usecases/load_auth_data.dart';
import 'package:spotoffline/features/auth/domain/usecases/logout.dart';
import 'package:spotoffline/core/di/service_locator.dart';

class AuthNotifier extends StateNotifier<AuthData?> {
  AuthNotifier(
    this._listenForAuthSuccess,
    this._loadAuthData,
    this._logout,
  ) : super(null);

  final ListenForAuthSuccess _listenForAuthSuccess;
  final LoadAuthData _loadAuthData;
  final Logout _logout;

  Future<void> logout() async {
    await _logout();
  }

  void loadAuthData() {
    final dataState = _loadAuthData();
    if (dataState is DataSuccess) {
      state = dataState.data!;
    } else {
      state = null;
    }
  }

  Future<DataState<AuthData>> listenForAuthSuccess() async {
    final dataState = await _listenForAuthSuccess();
    if (dataState is DataSuccess) {
      state = dataState.data!;
    }

    return dataState;
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthData?>((ref) => AuthNotifier(
          ListenForAuthSuccess(getIt<AuthRepository>()),
          LoadAuthData(getIt<AuthRepository>()),
          Logout(getIt<AuthRepository>()),
        ));
