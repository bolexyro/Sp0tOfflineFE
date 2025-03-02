import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
import 'package:spotoffline/features/library/presentation/widgets/track_card.dart';

class LikedSongsScreen extends ConsumerStatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  ConsumerState<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends ConsumerState<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ref.read(libraryProvider.notifier).getLibrary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final dataState = snapshot.data!;

          if (dataState is DataException) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(dataState.exceptionMessage!),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(bottom: 10),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
            return const Center(
              child: Text("An error occurred"),
            );
          }

          final libraryState = ref.read(libraryProvider);

          if (libraryState == null) {
            return const Center(
              child: Text('No liked songs'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: libraryState.tracks
                  .map((track) => TrackCard(track: track))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
