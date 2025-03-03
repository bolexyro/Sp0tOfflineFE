import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotoffline/features/auth/data/models/auth_data_model.dart';
import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/data/models/user_model.dart';

class LocalDataSource {
  const LocalDataSource(this.prefsWithCache);
  final SharedPreferencesWithCache prefsWithCache;

  Future<void> saveAuthData(AuthDataModel authData) async {
    if (authData.user != null) {
      await prefsWithCache.setString('name', authData.user!.name);
      await prefsWithCache.setStringList('images', authData.user!.images);
      await prefsWithCache.setString('email', authData.user!.email);
      await prefsWithCache.setString('id', authData.user!.id);
    }
    if (authData.token != null) {
      await prefsWithCache.setString(
          'accessToken', authData.token!.accessToken);
      await prefsWithCache.setString(
          'refreshToken', authData.token!.refreshToken);
    }
  }

  AuthDataModel? getAuthData() {
    final String? name = prefsWithCache.getString('name');
    final List<String>? images = prefsWithCache.getStringList('images');
    final String? email = prefsWithCache.getString('email');
    final String? id = prefsWithCache.getString('id');
    final String? accessToken = prefsWithCache.getString('accessToken');
    final String? refreshToken = prefsWithCache.getString('refreshToken');

    if (name == null ||
        images == null ||
        email == null ||
        id == null ||
        accessToken == null ||
        refreshToken == null) {
      return null;
    }
    return AuthDataModel(
        user: UserModel(id: id, name: name, images: images, email: email),
        token: TokenModel(accessToken, refreshToken));
  }

  Future<void> deleteAuthData() async {
    await prefsWithCache.remove('name');
    await prefsWithCache.remove('images');
    await prefsWithCache.remove('email');
    await prefsWithCache.remove('id');
    await prefsWithCache.remove('accessToken');
    await prefsWithCache.remove('refreshToken');
  }
}
