import 'package:flutter/material.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const ShapeDecoration(
                          shape: CircleBorder(), color: Colors.black54),
                      child: const Icon(Icons.expand_more),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          track.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          track.artistsString,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30)
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    track.lyrics!,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
