import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotoffline/constants.dart';
import 'package:spotoffline/models/tokens.dart';
import 'package:spotoffline/models/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyWebViewScreen extends StatefulWidget {
  const SpotifyWebViewScreen({super.key});

  @override
  State<SpotifyWebViewScreen> createState() => _SpotifyWebViewScreenState();
}

class _SpotifyWebViewScreenState extends State<SpotifyWebViewScreen> {
  final _channel = WebSocketChannel.connect(
    Uri.parse(ApiEndpoints.tokenWebsocket),
  );

  double loadProgress = 0;
  bool isLoading = false;

  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          setState(() => loadProgress = progress / 100);
          // Update loading bar.
        },
        onPageStarted: (String url) {
          setState(() => isLoading = true);
        },
        onPageFinished: (String url) {
          setState(() => isLoading = false);
        },
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(ApiEndpoints.login));

  @override
  void initState() {
    super.initState();
    _channel.stream.listen((data) {
      try {
        final json = jsonDecode(data);
        if (!json.containsKey('user')) {
          throw const FormatException();
        }

        Navigator.of(context).pop(
          User(
            name: json['user']['display_name'],
            images: List<String>.from(json['user']['images']),
            email: json['user']['email'],
            id: json['user']['id'],
            tokens: Tokens(json['token_data']['access_token'],
                json['token_data']['access_token']),
          ),
        );
      } catch (e) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if (await controller.canGoForward()) {
                controller.goForward();
              }
            },
          )
        ],
      ),
      body: Column(children: [
      if (isLoading)  LinearProgressIndicator(value: loadProgress, color: Colors.green),
        Expanded(
          child: WebViewWidget(
            controller: controller,
          ),
        )
      ]),
    );
  }
}
