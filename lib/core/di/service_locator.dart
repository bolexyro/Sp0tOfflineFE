import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotoffline/core/auth/token_manager.dart';
import 'package:spotoffline/core/network/dio_client.dart';
import 'package:spotoffline/features/auth/data/data_sources/local_data_source.dart';
import 'package:spotoffline/features/auth/data/data_sources/websocket_data_source.dart';
import 'package:spotoffline/features/auth/data/repository/auth_repository.dart';
import 'package:spotoffline/features/auth/domain/repository/auth_repository.dart';
import 'package:spotoffline/features/library/data/data_source/remote_data_source.dart';
import 'package:spotoffline/features/library/data/repository/library_repository.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferencesWithCache prefsWithCache =
      await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
  getIt.registerSingleton<SharedPreferencesWithCache>(prefsWithCache);

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      const WebsocketDataSource(), LocalDataSource(prefsWithCache)));

  getIt.registerSingleton<TokenManager>(
      TokenManager(accessToken: 'accessToken', refreshToken: 'refreshToken'));
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerSingleton<LibraryRepository>(
      LibraryRepositoryImpl(RemoteDataSource(getIt<DioClient>().dio)));
}
