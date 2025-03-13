import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/features/library/domain/entity/playlist.dart';
import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
import 'package:spotoffline/features/library/presentation/screens/tracks_screen.dart';

class PlaylistCard extends ConsumerWidget {
  const PlaylistCard({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    const double padding = 8;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(padding),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TracksScreen(
                sourceType: "PLAYLIST",
                getTracks: ref
                    .read(libraryProvider.notifier)
                    .getPlaylistTracks(playlist.id),
                screenTitle: playlist.name,
              ),
            ),
          ),
          child: SizedBox(
            width: constraints.maxWidth / 2 - 2 * padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constraints.maxWidth / 2 - 2 * padding,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(playlist.images[1].url),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                const SizedBox(height: 5),
                Text(
                  playlist.name,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Playlist · ${playlist.ownerName}',
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
