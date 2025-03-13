import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/features/library/domain/entity/album.dart';
import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
import 'package:spotoffline/features/library/presentation/screens/tracks_screen.dart';

class AlbumCard extends ConsumerWidget {
  const AlbumCard({
    super.key,
    required this.album,
  });

  final Album album;

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
                sourceType: "ALBUM",
                getTracks:
                    ref.read(libraryProvider.notifier).getAlbumTracks(album.id),
                screenTitle: album.name,
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
                          image: NetworkImage(album.images[1].url),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                const SizedBox(height: 5),
                Text(
                  album.name,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${album.type.replaceFirst(album.type[0], album.type[0].toUpperCase())} · ${album.artists[0].name}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
