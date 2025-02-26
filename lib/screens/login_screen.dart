import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotoffline/models/user.dart';
import 'package:spotoffline/providers/user_provider.dart';
import 'package:spotoffline/screens/home_screen.dart';
import 'package:spotoffline/screens/spotify_web_view_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
                  _isLoading = true;
                });
                final User? user = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SpotifyWebViewScreen()));
                if (user != null) {
                  ref.read(userDataProvider.notifier).updateUserData(user);
                  final SharedPreferencesAsync asyncPrefs =
                      SharedPreferencesAsync();
                  await asyncPrefs.setString('name', user.name);
                  await asyncPrefs.setStringList('images', user.images);
                  await asyncPrefs.setString('email', user.email);
                  await asyncPrefs.setString('id', user.id);
                  await asyncPrefs.setString(
                      'accessToken', user.tokens.accessToken);
                  await asyncPrefs.setString(
                      'refreshToken', user.tokens.refreshToken);
                  print('bolexyronations');
                  print(await asyncPrefs.getString('name'));
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  }
                }
                setState(() {
                  _isLoading = false;
                });
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
