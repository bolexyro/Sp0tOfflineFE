import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotoffline/core/data_state.dart';
import 'package:spotoffline/features/auth/presentation/screens/spotify_web_view_screen.dart';
import 'package:spotoffline/core/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    final DataState? dataState = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SpotifyWebViewScreen(),
      ),
    );
    if (dataState != null) {
      if (context.mounted) {
        if (dataState is DataException) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(dataState.exceptionMessage!),
            backgroundColor: Colors.red,
          ));
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _login,
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
