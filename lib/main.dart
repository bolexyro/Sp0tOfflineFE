import 'package:flutter/material.dart';
import 'package:spotoffline/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpotOffline',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(    
          seedColor: const Color.fromARGB(255, 5, 71, 7),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
