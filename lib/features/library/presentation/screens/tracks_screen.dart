import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/presentation/widgets/track_list_tile.dart';

class TracksScreen extends ConsumerStatefulWidget {
  const TracksScreen({
    super.key,
    required this.getTracks,
    required this.screenTitle,
    required this.sourceType,
  });

  final Future<List<Track>> getTracks;
  final String screenTitle;
  final String sourceType;
  @override
  ConsumerState<TracksScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends ConsumerState<TracksScreen> {
  late final getTracksFuture = widget.getTracks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Color.fromARGB(183, 11, 87, 27),
                  ],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop()),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      widget.screenTitle,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getTracksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  final likedSongs = snapshot.data!;
                  if (likedSongs.isEmpty) {
                    return const Center(
                      child: Text('No Tracks here'),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) => TrackListTile(
                      track: likedSongs[index],
                      sourceType: widget.sourceType,
                      sourceName: widget.screenTitle,
                    ),
                    itemCount: likedSongs.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
