import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/providers/liked_songs_provider.dart';
import 'package:spotoffline/providers/user_provider.dart';
import 'package:spotoffline/widgets/track_card.dart';

class LikedSongsScreen extends ConsumerStatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  ConsumerState<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends ConsumerState<LikedSongsScreen> {
  late final Future<void> getLikedSongsFuture = getLikedSongs();

  Future<void> getLikedSongs() async {
    await ref
        .read(likedSongsProvider.notifier)
        .getLikedSongs(ref.read(userDataProvider).tokens.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getLikedSongsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          print(ref.read(likedSongsProvider).length);
          return SingleChildScrollView(
            child: Column(
              children: ref
                  .read(likedSongsProvider)
                  .map((track) => TrackCard(track: track))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
