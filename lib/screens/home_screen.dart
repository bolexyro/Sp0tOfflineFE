import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/widgets/playlist_card.dart';
import 'package:spotoffline/widgets/profile_circle_avatar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('SpotOffline'),
          actions: const [
            ProfileCircleAvatar(),
            SizedBox(width: 20),
          ]),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          PlaylistCard(
            text: "Liked Songs",
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
