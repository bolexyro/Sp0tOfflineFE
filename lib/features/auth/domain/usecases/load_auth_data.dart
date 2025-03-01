import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';

class LoadAuthData {
  const LoadAuthData(this.authRepository);
  final AuthRepository authRepository;

  DataState<AuthData> call() {
    return authRepository.loadAuthData();
  }
}
