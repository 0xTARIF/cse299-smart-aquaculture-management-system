import 'package:flutter/material.dart';
import 'screens/home/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {'/login': (context) => const LoginScreen()},
    );
  }
}
