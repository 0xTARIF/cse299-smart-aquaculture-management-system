import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/farm_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? userId;
  String? userName;
  bool isLoading = true;
  //int _selectedNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Hind Siliguri text style helper
  TextStyle _hindStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = const Color(0xFF1A1A2E),
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: 'HindSiliguri',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  @override
  void initState() {
    super.initState();
    loadUserAndFarms();
  }

  void loadUserAndFarms() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    final name = prefs.getString('userName');

    if (id != null) {
      userId = id;
      userName = name ?? "ব্যবহারকারী";
      await ref.read(farmProvider.notifier).fetchFarms(userId!);
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final farms = ref.watch(farmProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildGreeting(),
                    const SizedBox(height: 20),
                    _buildSearchRow(),
                    const SizedBox(height: 14),
                    _buildCreateFarmButton(),
                    const SizedBox(height: 22),
                    _buildFarmListHeader(farms),
                    const SizedBox(height: 10),
                    _buildFarmList(farms),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Top bar ──────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.waves, color: Color(0xFF0D3B6E), size: 24),
          const SizedBox(width: 10),
          Text(
            'আকুয়াহার্ভেস্ট প্রো',
            style: _hindStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }

  // ── Greeting ─────────────────────────────────────────────────────────────

  Widget _buildGreeting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFFE2E8F0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/avatar_placeholder.png',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.person, color: Color(0xFF64748B), size: 32),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'হ্যালো, ${userName ?? 'ব্যবহারকারী'} !',
                style: _hindStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0D3B6E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'আপনার খামারের আজকের অবস্থা এক নজরে দেখে নিন।',
                style: _hindStyle(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Search row ───────────────────────────────────────────────────────────

  Widget _buildSearchRow() {
    return Row(
      children: [
        // Search field
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF1F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _searchController,
              style: _hindStyle(fontSize: 14, color: const Color(0xFF1A1A2E)),
              decoration: InputDecoration(
                hintText: 'খামার খুঁজুন',
                hintStyle: _hindStyle(
                  fontSize: 14,
                  color: const Color(0xFF94A3B8),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF64748B),
                  size: 22,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Map button — icon and text in same row
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              // TODO: map
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: Color(0xFF0D3B6E),
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'ম্যাপে\nখুঁজুন',
                    textAlign: TextAlign.center,
                    style: _hindStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D3B6E),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Create farm button ────────────────────────────────────────────────────

  Widget _buildCreateFarmButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D3B6E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        icon: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, size: 16, color: Colors.white),
        ),
        label: Text(
          'নতুন খামার তৈরী করুন',
          style: _hindStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          // TODO: create farm
        },
      ),
    );
  }

  // ── Farm list header ──────────────────────────────────────────────────────

  Widget _buildFarmListHeader(List farms) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'আপনার খামারসমূহ',
          style: _hindStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'মোট ${farms.length}টি',
            style: _hindStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3949AB),
            ),
          ),
        ),
      ],
    );
  }

  // ── Farm list ─────────────────────────────────────────────────────────────

  Widget _buildFarmList(List farms) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(color: Color(0xFF0D3B6E)),
        ),
      );
    }

    if (farms.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            const Icon(Icons.water, size: 48, color: Color(0xFFCBD5E1)),
            const SizedBox(height: 12),
            Text(
              'কোন খামারে যুক্ত নেই',
              style: _hindStyle(fontSize: 14, color: const Color(0xFF94A3B8)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: farms.asMap().entries.map((entry) {
        final farm = entry.value as Map<String, dynamic>;
        final isActive = farm['status'] == 'active' ? true : false;
        return _buildFarmCard(farm, isActive: isActive);
      }).toList(),
    );
  }

  Widget _buildFarmCard(Map<String, dynamic> farm, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left image thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Container(
              width: 82,
              height: 82,
              color: const Color(0xFFBFDBFE),
              child: farm['imageUrl'] != null
                  ? Image.network(
                      farm['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.water,
                        color: Color(0xFF3B82F6),
                        size: 36,
                      ),
                    )
                  : const Icon(Icons.water, color: Color(0xFF3B82F6), size: 36),
            ),
          ),

          const SizedBox(width: 14),

          // Farm info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  farm['name'] ?? '',
                  style: _hindStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        farm['location'] ?? '',
                        style: _hindStyle(
                          fontSize: 12,
                          color: const Color(0xFF6B7280),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status badge
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFDCFCE7)
                    : const Color(0xFFFEF9C3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isActive ? 'সক্রিয়' : 'সক্রিয়',
                style: _hindStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFCA8A04),
                ),
              ),
            ),
          ),

          // Right accent bar
          Container(
            width: 5,
            height: 82,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF22C55E)
                  : const Color(0xFFFACC15),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // // ── Bottom nav ────────────────────────────────────────────────────────────

  // Widget _buildBottomNavBar() {
  //   final items = [
  //     {'icon': Icons.home_rounded, 'label': 'হোম'},
  //     {'icon': Icons.qr_code_scanner, 'label': 'স্ক্যান'},
  //     {'icon': Icons.person_outline_rounded, 'label': 'প্রোফাইল'},
  //   ];

  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Color(0x14000000),
  //           blurRadius: 12,
  //           offset: Offset(0, -3),
  //         ),
  //       ],
  //     ),
  //     child: SafeArea(
  //       top: false,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: items.asMap().entries.map((entry) {
  //             final i = entry.key;
  //             final item = entry.value;
  //             final selected = _selectedNavIndex == i;

  //             return GestureDetector(
  //               onTap: () {
  //                 setState(() => _selectedNavIndex = i);

  //                 if (i == 2) {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (_) => const ProfileScreen()),
  //                   );
  //                 }
  //               },
  //               behavior: HitTestBehavior.opaque,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   AnimatedContainer(
  //                     duration: const Duration(milliseconds: 200),
  //                     curve: Curves.easeInOut,
  //                     width: selected ? 64 : 44,
  //                     height: selected ? 64 : 44,
  //                     decoration: BoxDecoration(
  //                       color: selected
  //                           ? const Color(0xFF0D3B6E)
  //                           : Colors.transparent,
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: Icon(
  //                       item['icon'] as IconData,
  //                       color: selected
  //                           ? Colors.white
  //                           : const Color(0xFF94A3B8),
  //                       size: selected ? 28 : 24,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     item['label'] as String,
  //                     style: _hindStyle(
  //                       fontSize: 11,
  //                       fontWeight: selected
  //                           ? FontWeight.w600
  //                           : FontWeight.w400,
  //                       color: selected
  //                           ? const Color(0xFF0D3B6E)
  //                           : const Color(0xFF94A3B8),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
