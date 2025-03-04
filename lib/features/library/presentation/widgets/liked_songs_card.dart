import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
import 'package:spotoffline/features/library/presentation/screens/tracks_screen.dart';

class LikedSongsCard extends ConsumerWidget {
  const LikedSongsCard({super.key});

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
                getTracks: ref.read(libraryProvider.notifier).getLikedSongs(),
                screenTitle: 'Liked Songs',
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 94, 23, 209),
                          Color.fromARGB(255, 192, 165, 236),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Liked Songs',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Text(
                  'Playlist',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
