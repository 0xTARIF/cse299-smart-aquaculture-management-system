import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> data = [
    {
      "title": "মাছের রোগ নির্ণয় করুন",
      "subtitle":
          "আপনার ফোনের ক্যামেরা দিয়ে মাছ স্ক্যান করুন এবং তাৎক্ষণিক রোগ নির্ণয় করুন",
      "image": "assets/images/fish.png",
    },
    {
      "title": "খামারের অবস্থা ট্র্যাক করুন",
      "subtitle": "খাবার, বৃদ্ধি এবং খরচ ট্র্যাক করুন",
      "image": "assets/images/chart.png",
    },
    {
      "title": "বিশেষজ্ঞের পরামর্শ নিন",
      "subtitle": "AI চ্যাটবট এর মাধ্যমে সমাধান নিন",
      "image": "assets/images/robot.png",
    },
  ];

  void finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
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
  }

  void nextPage() {
    if (currentPage == data.length - 1) {
      finishOnboarding();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Column(
          children: [
            // Left aligned title
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "অ্যাকুয়াহারভেস্ট প্রো",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: data.length,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Main card with exact color
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        height: 360,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF002B46,
                          ), // exact color from you
                          borderRadius: BorderRadius.circular(35),
                        ),

                        // Image fills card naturally
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Image.asset(
                            data[index]["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        data[index]["title"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D3B5C),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          data[index]["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                data.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(4),
                  width: currentPage == index ? 16 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color(0xFF0D3B5C)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D3B5C),
                  minimumSize: const Size(double.infinity, 55),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  currentPage == data.length - 1 ? "শুরু করুন" : "পরবর্তী",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Skip button with correct color
            currentPage != data.length - 1
                ? TextButton(
                    onPressed: finishOnboarding,
                    child: const Text(
                      "এড়িয়ে যান",
                      style: TextStyle(
                        color: Color.fromARGB(255, 40, 40, 40),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const SizedBox(),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
