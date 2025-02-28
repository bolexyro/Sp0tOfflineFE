import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotoffline/features/auth/data/data_sources/local_data_source.dart';
import 'package:spotoffline/features/auth/data/data_sources/websocket_data_source.dart';
import 'package:spotoffline/features/auth/data/repository/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferencesWithCache prefsWithCache =
      await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
  getIt.registerSingleton<SharedPreferencesWithCache>(prefsWithCache);

  getIt.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl(
      const WebsocketDataSource(), LocalDataSource(prefsWithCache)));
}
