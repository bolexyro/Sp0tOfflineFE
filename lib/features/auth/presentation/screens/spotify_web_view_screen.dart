import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/network/api_endpoints.dart';
import 'package:spotoffline/features/auth/presentation/providers/auth_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyWebViewScreen extends ConsumerStatefulWidget {
  const SpotifyWebViewScreen({super.key});

  @override
  ConsumerState<SpotifyWebViewScreen> createState() =>
      _SpotifyWebViewScreenState();
}

class _SpotifyWebViewScreenState extends ConsumerState<SpotifyWebViewScreen> {

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

  Future<void> waitForWebsocketSuccess() async {
    final dataState =
        await ref.read(authProvider.notifier).listenForAuthSuccess();
    if (context.mounted) Navigator.of(context).pop(dataState);
  }

  @override
  void initState() {
    super.initState();
    waitForWebsocketSuccess();
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
        if (isLoading)
          LinearProgressIndicator(value: loadProgress, color: Colors.green),
        Expanded(
          child: WebViewWidget(
            controller: controller,
          ),
        )
      ]),
    );
  }
}
