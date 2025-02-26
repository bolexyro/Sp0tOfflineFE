import 'package:flutter/material.dart';
import 'package:spotoffline/screens/spotify_web_view_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  // _isLoading = true;
                });
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SpotifyWebViewScreen()));
              },
              child: _isLoading
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
