import 'package:flutter/material.dart';
import 'package:spotoffline/screens/home_screen.dart';
import 'package:spotoffline/screens/spotify_web_view_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final isAuthenticated = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SpotifyWebViewScreen()));
                if (isAuthenticated == true) {
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  }
                }
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
