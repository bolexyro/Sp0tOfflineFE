import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/data/repository/auth_repository.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/usecases/listen_for_auth_success.dart';
import 'package:spotoffline/service_locator.dart';

class AuthNotifier extends StateNotifier<AuthData?> {
  AuthNotifier(this._listenForAuthSuccess) : super(null);

  final ListenForAuthSuccess _listenForAuthSuccess;

  Future<DataState<AuthData>> listenForAuthSuccess() async {
    final dataState = await _listenForAuthSuccess();
    if (dataState is DataSuccess) {
      state = dataState.data!;
    }

    return dataState;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthData?>(
    (ref) => AuthNotifier(ListenForAuthSuccess(getIt<AuthRepositoryImpl>())));
