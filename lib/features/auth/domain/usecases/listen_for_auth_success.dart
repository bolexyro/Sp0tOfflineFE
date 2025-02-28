import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';

class ListenForAuthSuccess {
  const ListenForAuthSuccess(this.authRepository);
  final AuthRepository authRepository;

  Future<DataState<AuthData>> call() async {
    return authRepository.listenForAuthSuccess();
  }
}
