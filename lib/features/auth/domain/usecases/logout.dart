import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';

class Logout {
  const Logout(this.authRepository);
  final AuthRepository authRepository;

  Future<void> call() async {
    await authRepository.logout();
  }
}
