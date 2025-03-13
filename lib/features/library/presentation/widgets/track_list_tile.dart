import 'package:flutter/material.dart';
import 'package:spotoffline/core/utils.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/presentation/screens/track_screen.dart';

class TrackListTile extends StatelessWidget {
  const TrackListTile({
    super.key,
    required this.track,
    required this.sourceType,
    required this.sourceName,
  });

  final Track track;
  final String sourceType;
  final String sourceName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Image.network(
          track.album.images[0].url,
          width: 50,
          height: 50,
        ),
      ),
      title: Text(
        track.name,
        maxLines: 1,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      subtitle: Text(
        "${track.artistsString} · ${track.album.name}",
        maxLines: 1,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      onTap: () => slideInNavigate(
        context,
        TrackScreen(
          track: track,
          sourceType: sourceType,
          sourceName: sourceName,
        ),
      ),
    );
  }
}
