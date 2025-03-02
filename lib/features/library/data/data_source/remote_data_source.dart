import 'package:dio/dio.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/network/api_endpoints.dart';
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
}
