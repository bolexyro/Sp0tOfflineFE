import 'package:dio/dio.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/network/api_endpoints.dart';
import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/playlist_model.dart';
import 'package:spotoffline/features/library/data/models/track_model.dart';

class RemoteDataSource {
  const RemoteDataSource(this._dio);
  final Dio _dio;

  Future<DataState<List<TrackModel>>> getLikedSongs() async {
    try {
      final response = await _dio.get(ApiEndpoints.likedSongs);

      return DataSuccess((response.data as List)
          .map((json) => TrackModel.fromJson(json))
          .toList());
    } catch (e) {
      return DataException('An error occurred: $e');
    }
  }

  Future<DataState<List<AlbumModel>>> getAlbums() async {
    try {
      final response = await _dio.get(ApiEndpoints.albums);
      return DataSuccess((response.data as List)
          .map((json) => AlbumModel.fromJson(json))
          .toList());
    } catch (e) {
      return DataException('An error occurred: $e');
    }
  }

  Future<DataState<List<TrackModel>>> getAlbumTracks(AlbumModel album) async {
    try {
      final response = await _dio.get(ApiEndpoints.albumTracks(album.id));
      return DataSuccess((response.data as List).map((json) {
        json['album'] = album.toJson();

        return TrackModel.fromJson(json);
      }).toList());
    } catch (e) {
      return DataException('An error occurred: $e');
    }
  }

  Future<DataState<List<PlaylistModel>>> getPlaylists() async {
    try {
      final response = await _dio.get(ApiEndpoints.playlists);
      return DataSuccess((response.data as List)
          .map((json) => PlaylistModel.fromJson(json))
          .toList());
    } catch (e) {
      return DataException('An error occurred: $e');
    }
  }

  Future<DataState<List<TrackModel>>> getPlaylistTracks(
      String playlistId) async {
    try {
      final response = await _dio.get(ApiEndpoints.playlistTracks(playlistId));
      return DataSuccess((response.data as List)
          .map((json) => TrackModel.fromJson(json))
          .toList());
    } catch (e) {
      return DataException('An error occurred: $e');
    }
  }
}
