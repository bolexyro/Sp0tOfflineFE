import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/di/service_locator.dart';
import 'package:spotoffline/features/library/data/repository/library_repository.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/domain/usecases/get_library.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class LibraryNotifier extends StateNotifier<LibraryState?> {
  LibraryNotifier(this._getLibraryUseCase) : super(null);

  final GetLibraryUseCase _getLibraryUseCase;

  Future<DataState<List<Track>>> getLibrary() async {
    final dataState = await _getLibraryUseCase();
    if (dataState is DataSuccess) {
      state = LibraryState(tracks: dataState.data!);
    }
    return dataState;
  }
}

final libraryProvider = StateNotifierProvider<LibraryNotifier, LibraryState?>(
  (ref) => LibraryNotifier(
    GetLibraryUseCase(getIt<LibraryRepositoryImpl>()),
  ),
);
