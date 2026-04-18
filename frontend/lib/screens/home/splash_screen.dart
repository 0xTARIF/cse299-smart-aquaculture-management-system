import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/onboarding_screen.dart';
import '../auth/login_screen.dart';
//import '../home/home_screen.dart';

import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  // MAIN LOGIC
  void checkFirstTime() async {
    // Splash delay
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()), // ✅ CHANGED
      );
    } else if (seenOnboarding) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const LoginScreen(),
          transitionsBuilder: (_, animation, _, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),

            /// CENTER CONTENT
            Center(
              child: Column(
                children: [
                  /// LOGO
                  Image.asset(
                    'assets/images/logo.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 30),

                  /// TITLE
                  const Text(
                    "অ্যাকুয়াহারভেস্ট প্রো",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HindSiliguri',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D3B5C),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// SUBTITLE
                  const Text(
                    "আধুনিক উপায়ে মাছ চাষ করুন",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HindSiliguri',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// PROGRESS BAR
                  SizedBox(
                    width: 150,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xFF0D3B5C),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),

            /// FOOTER
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "© CSE299.14 GROUP 2",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
