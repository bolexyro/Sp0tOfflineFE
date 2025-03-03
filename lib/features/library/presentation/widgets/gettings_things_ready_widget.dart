import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';

class GettingsThingsReadyWidget extends ConsumerStatefulWidget {
  const GettingsThingsReadyWidget({super.key});

  @override
  ConsumerState<GettingsThingsReadyWidget> createState() =>
      _GettingsThingsReadyScreenState();
}

class _GettingsThingsReadyScreenState
    extends ConsumerState<GettingsThingsReadyWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(libraryProvider.notifier).getLibrary());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(),
        const Text(
          'Getting your stuff from Spotify',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        if (ref.watch(libraryProvider).isLoading)
          const CircularProgressIndicator(
            color: Colors.green,
          ),
        const SizedBox(height: 20),
        Text(
          ref.watch(libraryProvider).libraryAction.name,
        ),
        const SizedBox(
          height: 20,
        ),
        if (ref.watch(libraryProvider).libraryAction == LibraryAction.failed)
          ElevatedButton(
            child: const Text('Retry'),
            onPressed: () {
              ref.read(libraryProvider.notifier).getLibrary();
            },
          )
      ],
    );
  }
}
