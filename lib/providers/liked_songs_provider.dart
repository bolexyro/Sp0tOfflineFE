import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/constants.dart';
import 'package:spotoffline/models/spotify_models.dart';

class LikedSongsNotifier extends StateNotifier<List<Track>> {
  LikedSongsNotifier() : super([]);

  final dio = Dio();

  Future<void> getLikedSongs(String accessToken) async {
    final response = await dio.get(
      ApiEndpoints.likedSongs,
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    state = (response.data as List).map((trackMap) {
      print(trackMap);
      return Track.fromJson(trackMap);
    }).toList();
  }
}

final likedSongsProvider =
    StateNotifierProvider<LikedSongsNotifier, List<Track>>(
  (ref) => LikedSongsNotifier(),
);
