import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
import 'package:spotoffline/features/library/presentation/providers/library_state.dart';
import 'package:spotoffline/features/library/presentation/widgets/album_card.dart';
import 'package:spotoffline/features/library/presentation/widgets/gettings_things_ready_widget.dart';
import 'package:spotoffline/features/library/presentation/widgets/liked_songs_card.dart';
import 'package:spotoffline/features/library/presentation/widgets/playlist_card.dart';
import 'package:spotoffline/core/widgets/profile_circle_avatar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final libraryState = ref.watch(libraryProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your Library',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            actions: const [
              ProfileCircleAvatar(),
              SizedBox(width: 20),
            ],
          ),
          body: libraryState.libraryData == null && !libraryState.isOffline
              ? const Center()
              : libraryState.libraryData == null && libraryState.isOffline
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        children: [
                          if (libraryState.libraryData!.totalLikedSongs != null)
                            const LikedSongsCard(),
                          for (final playlist
                              in libraryState.libraryData!.playlists)
                            PlaylistCard(
                              playlist: playlist,
                            ),
                          for (final album in libraryState.libraryData!.albums)
                            AlbumCard(
                              album: album,
                            ),
                        ],
                      ),
                    ),
        ),
        if (libraryState.libraryAction != LibraryAction.completed &&
            !libraryState.isOffline)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: const Material(
                  color: Colors.transparent,
                  child: GettingsThingsReadyWidget(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
