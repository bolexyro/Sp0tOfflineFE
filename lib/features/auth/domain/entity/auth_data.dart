import 'package:spotoffline/features/auth/domain/entity/token.dart';
import 'package:spotoffline/features/auth/domain/entity/user.dart';

class AuthData {
  const AuthData({required this.user, required this.token});

  final User? user;
  final Token? token;

  AuthData.withDefault()
      : this(user: User.withDefault(), token: Token.withDefault());
}
