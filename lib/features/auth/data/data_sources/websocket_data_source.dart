import 'dart:convert';

import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/core/network/api_endpoints.dart';
import 'package:spotoffline/features/auth/data/models/auth_data_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketDataSource {
  const WebsocketDataSource();

  Future<DataState<AuthDataModel>> listenForAuthSuccess() async {
    late WebSocketChannel channel;
    try {
      channel =
          WebSocketChannel.connect(Uri.parse(ApiEndpoints.tokenWebsocket));
      final data = await channel.stream.first;
      final json = jsonDecode(data);
      if (!json.containsKey('user')) {
        throw const FormatException();
      }

      return DataSuccess(AuthDataModel.fromJson(json));
    } catch (e) {
      return DataException('An error occured: $e');
    } finally {
      channel.sink.close();
    }
  }
}
