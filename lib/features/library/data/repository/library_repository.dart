import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/extensions.dart';
import 'package:spotoffline/features/library/data/data_source/remote_data_source.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  const LibraryRepositoryImpl(this._remoteDataSource);

  final RemoteDataSource _remoteDataSource;
  @override
  Future<DataState<List<Track>>> getLibrary() async {
    final dataState = await _remoteDataSource.getLikedSongs();
    if (dataState is DataSuccess) {
      final tracks =
          dataState.data!.map((trackModel) => trackModel.toEntity()).toList();
      return DataSuccess(tracks);
    }
    return DataException(dataState.exceptionMessage!);
  }
}
