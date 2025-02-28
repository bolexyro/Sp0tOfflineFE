import 'dart:convert';

import 'package:spotoffline/constants.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/data/models/auth_data_model.dart';
import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/data/models/user_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketDataSource {
  const WebsocketDataSource();

  Future<DataState<AuthDataModel>> listenForAuthSuccess() async {
    final channel =
        WebSocketChannel.connect(Uri.parse(ApiEndpoints.tokenWebsocket));
    final data = await channel.stream.first;
    try {
      final json = jsonDecode(data);
      if (!json.containsKey('user')) {
        throw const FormatException();
      }

      return DataSuccess(AuthDataModel(
          user: UserModel.fromJson(json['user']),
          token: TokenModel.fromJson(json['token_data'])));
    } catch (e) {
      return const DataException('An error occured');
    }
    finally {
      channel.sink.close();
    }
  }
}
