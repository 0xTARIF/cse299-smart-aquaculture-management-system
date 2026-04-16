import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  void handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("সব ঘর পূরণ করুন")));
      return;
    }

    bool success = await ApiService.login(email, password);

    if (success) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("লগইন সফল")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("HOME SCREEN"))),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("ইমেইল বা পাসওয়ার্ড ভুল")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// LOGO
              Image.asset('assets/images/logo.png', width: 80, height: 80),

              const SizedBox(height: 20),

              /// TITLE
              const Text(
                "অ্যাকুয়াহারভেস্ট প্রো",
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D3B5C),
                ),
              ),

              const SizedBox(height: 30),

              /// CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "লগইন করুন",
                      style: TextStyle(
                        fontFamily: 'HindSiliguri',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// EMAIL
                    const Text(
                      "ইমেইল ঠিকানা",
                      style: TextStyle(fontFamily: 'HindSiliguri'),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "example@email.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: const Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// PASSWORD
                    const Text(
                      "পাসওয়ার্ড",
                      style: TextStyle(fontFamily: 'HindSiliguri'),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: "••••••••",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// FORGOT PASSWORD
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "পাসওয়ার্ড ভুলে গেছেন?",
                          style: TextStyle(
                            fontFamily: 'HindSiliguri',
                            color: Color(0xFF0D3B5C),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D3B5C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "লগইন",
                          style: TextStyle(
                            fontFamily: 'HindSiliguri',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// DIVIDER
                    const Divider(),

                    const SizedBox(height: 10),

                    /// SIGNUP TEXT
                    const Center(
                      child: Text(
                        "আপনার কি কোনো অ্যাকাউন্ট নেই?",
                        style: TextStyle(fontFamily: 'HindSiliguri'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// SIGNUP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const SignupScreen(),
                              transitionsBuilder: (_, animation, __, child) {
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
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6E2E1),
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "নতুন অ্যাকাউন্ট তৈরি করুন",
                          style: TextStyle(fontFamily: 'HindSiliguri'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// FOOTER
              const Text(
                "© CSE299.14 GROUP 2",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
