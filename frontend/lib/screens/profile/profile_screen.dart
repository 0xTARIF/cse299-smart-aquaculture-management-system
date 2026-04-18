// lib/screens/profile/profile_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../providers/farm_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditMode = false;
  bool isLoading = true;

  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAbout = "";
  String userExperience = "";

  final String baseUrl = "http://127.0.0.1:8000"; //

  TextStyle _hindStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = const Color(0xFF1A1A2E),
  }) {
    return TextStyle(
      fontFamily: 'HindSiliguri',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) return;

    final res = await http.get(Uri.parse('$baseUrl/user/$userId'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      setState(() {
        userName = data['name'] ?? "";
        userEmail = data['email'] ?? "";
        userPhone = data['phone'] ?? "";
        userAbout = data['about'] ?? "";
        userExperience = data['experience']?.toString() ?? "";
        isLoading = false;
      });
    }
  }

  Future<void> updateProfile(
    String name,
    String phone,
    String about,
    String exp,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    await http.put(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "about": about,
        "experience": int.tryParse(exp),
      }),
    );

    await loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final farms = ref.watch(farmProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : isEditMode
            ? _editView(farms.length)
            : _profileView(farms.length),
      ),
    );
  }

  // ================= PROFILE VIEW =================

  Widget _profileView(int farmCount) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 10),

          // Top bar
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "প্রোফাইল",
                    style: _hindStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0D3B6E),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),

          const SizedBox(height: 10),

          const CircleAvatar(radius: 45),

          const SizedBox(height: 12),

          Text(
            userName.isEmpty ? "_" : userName,
            style: _hindStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 20),

          // Edit Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D3B6E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: Text(
                "প্রোফাইল এডিট করুন",
                style: _hindStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => setState(() => isEditMode = true),
            ),
          ),

          const SizedBox(height: 20),

          _section("আমার সম্পর্কে", userAbout),
          const SizedBox(height: 16),

          _contact("ইমেইল", userEmail),
          const SizedBox(height: 16),

          _contact("ফোন", userPhone),
          const SizedBox(height: 16),

          _stats(farmCount, userExperience),
        ],
      ),
    );
  }

  // ================= EDIT VIEW =================

  Widget _editView(int farmCount) {
    final nameCtrl = TextEditingController(text: userName);
    final emailCtrl = TextEditingController(text: userEmail);
    final phoneCtrl = TextEditingController(text: userPhone);
    final aboutCtrl = TextEditingController(text: userAbout);
    final expCtrl = TextEditingController(text: userExperience);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          // Top bar
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => isEditMode = false),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "প্রোফাইল সম্পাদনা",
                    style: _hindStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: 10),

          // Avatar + Name
          Row(
            children: [
              const CircleAvatar(radius: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  userName,
                  style: _hindStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Main Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name
                _label("পুরো নাম"),
                _inputField(nameCtrl, Icons.person),

                const SizedBox(height: 12),

                // Email (disabled)
                _label("ইমেইল"),
                _inputField(emailCtrl, Icons.email, enabled: false),

                const SizedBox(height: 12),

                // Phone
                _label("মোবাইল নম্বর"),
                _inputField(phoneCtrl, Icons.phone),

                const SizedBox(height: 12),

                // Experience
                _label("অভিজ্ঞতা (বছর)"),
                _inputField(expCtrl, Icons.timeline),

                const SizedBox(height: 12),

                // About
                _label("আমার সম্পর্কে"),
                _inputField(aboutCtrl, Icons.info, maxLines: 4),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D3B6E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.save, color: Colors.white),
              label: Text(
                "পরিবর্তনগুলো সংরক্ষণ করুন",
                style: _hindStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                await updateProfile(
                  nameCtrl.text,
                  phoneCtrl.text,
                  aboutCtrl.text,
                  expCtrl.text,
                );

                setState(() => isEditMode = false);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("আপডেট সফল")));
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _section(String title, String value) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _hindStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text(
              value.isEmpty ? "_" : value,
              style: _hindStyle(),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _contact(String title, String value) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ important
          children: [
            Text(title, style: _hindStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              value.isEmpty ? "_" : value,
              style: _hindStyle(fontWeight: FontWeight.w600),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stats(int farms, String exp) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            // Left side
            Expanded(
              child: Column(
                children: [
                  Text("মোট খামার", style: _hindStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    "$farms টি",
                    style: _hindStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            // Divider
            Container(height: 30, width: 1, color: const Color(0xFFE2E8F0)),

            // Right side
            Expanded(
              child: Column(
                children: [
                  Text("অভিজ্ঞতা", style: _hindStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    exp.isEmpty ? "_" : "$exp বছর",
                    style: _hindStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: _hindStyle(fontSize: 13, color: Colors.black54)),
    );
  }

  Widget _inputField(
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
    bool enabled = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        enabled: enabled,
        style: _hindStyle(),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          suffixIcon: Icon(icon, size: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
