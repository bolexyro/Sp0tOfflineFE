import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';
import 'package:spotoffline/features/library/presentation/widgets/lyrics_card.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: ()=>Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.expand_more,
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('PLAYING FROM $sourceType'),
                        Text(sourceName),
                      ],
                    ),
                  ),
                  const SizedBox(width: 38)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 32),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(track.album.images[0].url),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(track.artistsString),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(height: 32),
                    LyricsCard(track: track),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
