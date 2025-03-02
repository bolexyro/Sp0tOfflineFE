import 'package:flutter/material.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
class TrackCard extends StatelessWidget {
  const TrackCard({super.key, required this.track});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.network(
            track.album.images[0].url,
            width: 50,
            height: 50,
          ),
          Text(track.name)
        ],
      ),
    );
  }
}
