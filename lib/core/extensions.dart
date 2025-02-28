import 'package:spotoffline/features/auth/data/models/auth_data_model.dart';
import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/data/models/user_model.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/entity/token.dart';
import 'package:spotoffline/features/auth/domain/entity/user.dart';

extension AuthDataModelMapper on AuthDataModel {
  AuthData toEntity() => AuthData(user: user.toEntity(), token: token.toEntity());
}

extension UserModelMapper on UserModel {
  User toEntity() => User(id: id, name: name, images: images, email: email);
}
extension TokenModelMapper on TokenModel {
  Token toEntity() => Token(accessToken, refreshToken);
}
