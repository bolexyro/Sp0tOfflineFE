import 'package:flutter/material.dart';
import 'package:spotoffline/components/playlist_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SpotOffline'),
      ),
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
