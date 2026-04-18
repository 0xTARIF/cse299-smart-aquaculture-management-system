import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const OtpScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  void handleVerify() async {
    String otp = otpController.text.trim();

    if (otp.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("৬ সংখ্যার কোড দিন")));
      return;
    }

    bool success = await ApiService.verifyOtp(widget.email, otp);

    if (success) {
      /// CREATE USER IN BACKEND
      bool created = await ApiService.createUser(
        name: widget.name,
        email: widget.email,
        password: widget.password,
      );

      if (created) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("অ্যাকাউন্ট তৈরি হয়েছে")));

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("অ্যাকাউন্ট তৈরি ব্যর্থ")));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("ভুল OTP")));
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

            /// MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// LOGO
                    Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                      height: 80,
                    ),

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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "ভেরিফিকেশন কোড",
                            style: TextStyle(
                              fontFamily: 'HindSiliguri',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "আপনার ইমেইলে পাঠানো ৬ সংখ্যার কোড লিখুন",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'HindSiliguri',
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// OTP FIELD
                          TextField(
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 6,
                            style: const TextStyle(
                              fontSize: 20,
                              letterSpacing: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "------",
                              filled: true,
                              fillColor: const Color(0xFFF0F0F0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// VERIFY BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: handleVerify,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D3B5C),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "ভেরিফাই করুন",
                                style: TextStyle(
                                  fontFamily: 'HindSiliguri',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          /// RESEND
                          TextButton(
                            onPressed: () async {
                              bool success = await ApiService.sendOtp(
                                widget.email,
                              );

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("নতুন OTP পাঠানো হয়েছে"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("OTP পাঠানো যায়নি"),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "কোড পাননি? আবার পাঠান",
                              style: TextStyle(
                                fontFamily: 'HindSiliguri',
                                color: Color(0xFF0D3B5C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
