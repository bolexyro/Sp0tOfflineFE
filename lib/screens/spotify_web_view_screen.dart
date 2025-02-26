import 'package:flutter/material.dart';
import 'package:spotoffline/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyWebViewScreen extends StatefulWidget {
  const SpotifyWebViewScreen({super.key});

  @override
  State<SpotifyWebViewScreen> createState() => _SpotifyWebViewScreenState();
}

class _SpotifyWebViewScreenState extends State<SpotifyWebViewScreen> {
   late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          print("progress is $progress");
          // Update loading bar.
        },
        onPageStarted: (String url) {
          print("page $url started");
        },
        onPageFinished: (String url) {
          print("page $url finsished");
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
    )..loadRequest(Uri.parse(ApiEndpoints.login));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}