import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/data/models/user_model.dart';

class AuthDataModel {
  const AuthDataModel({required this.user, required this.token});

  final UserModel user;
  final TokenModel token;
}
