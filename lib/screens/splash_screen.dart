import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotoffline/screens/home_screen.dart';
import 'package:spotoffline/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Future<String?> loadUserNameFuture;

  Future<String?> loadUserName() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    return await asyncPrefs.getString('name');
  }

  @override
  void initState() {
    loadUserName().then((name) {
      if (name == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        return;
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
