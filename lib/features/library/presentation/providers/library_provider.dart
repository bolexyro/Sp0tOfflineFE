import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/di/service_locator.dart';
import 'package:spotoffline/features/library/domain/repository/library_repository.dart';
import 'package:spotoffline/features/library/domain/usecases/get_download_progress.dart';
import 'package:spotoffline/features/library/domain/usecases/get_library.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class LibraryNotifier extends StateNotifier<LibraryState> {
  LibraryNotifier(this._getLibraryUseCase, this._getDownloadProgressUseCase)
      : super(
          LibraryState(
            isLoading: false,
            libraryAction: LibraryAction.idle,
          ),
        );

  final GetLibraryUseCase _getLibraryUseCase;
  final GetDownloadProgressUseCase _getDownloadProgressUseCase;

  Future<void> getLibrary() async {
    state = LibraryState(
        isLoading: true, libraryAction: LibraryAction.idle, libraryData: null);
    _getDownloadProgressUseCase().listen((currentLibraryState) {
      state = currentLibraryState;
    });

    await _getLibraryUseCase();
  }
}

final libraryProvider = StateNotifierProvider<LibraryNotifier, LibraryState>(
  (ref) => LibraryNotifier(
    GetLibraryUseCase(getIt<LibraryRepository>()),
    GetDownloadProgressUseCase(getIt<LibraryRepository>()),
  ),
);
