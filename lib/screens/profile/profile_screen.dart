import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

import 'edit_profile_screen.dart';

import '../mood/mood_screen.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/profile_setting_tile.dart';
import '../../widgets/profile_stat_card.dart';
import '../dashboard/dashboard_screen.dart';
import '../activity/activity_screen.dart';
import '../water/water_screen.dart';
import '../statistics/statistics_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple responsive helper: clamp avatar/font sizes based on
    // screen width instead of using fixed values tuned for one
    // device. Most phones fall in the 340-430 range; tablets get
    // capped so things don't blow up too.
    final width = MediaQuery.of(context).size.width;

    final uid = AuthService().currentUser!.uid;
    print("LOGIN UID = $uid");

    final avatarRadius = (width * 0.18).clamp(56.0, 76.0);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          // Fixed mapping: BottomNavbar has 5 destinations
          // (Home, Activity, Water, Mood, Stats) but this switch
          // previously only handled 4 cases, so index 3 ("Mood")
          // incorrectly opened Statistics and index 4 ("Stats") did
          // nothing at all.
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardScreen()),
              );
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ActivityScreen()),
              );
              break;

            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WaterScreen()),
              );
              break;

            case 3:
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const MoodScreen(),
    ),
  );
  break;

            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StatisticsScreen()),
              );
              break;
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //================ HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ZenFit",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff35694A),
                    ),
                  ),
                  const Icon(Icons.person_outline, size: 26),
                ],
              ),
              const SizedBox(height: 28),

              //================ PROFILE =================
              Stack(
                children: [
                  CircleAvatar(
                    radius: avatarRadius + 5,
                    backgroundColor: const Color(0xffE5EFE8),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage:
                          const AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 4,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xff4F7F5D),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

StreamBuilder<UserModel>(
  stream: UserService().getUser(uid),
  builder: (context, snapshot) {

    if (snapshot.hasError) {
      return Center(
        child: Text(
          snapshot.error.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!snapshot.hasData) {
      return const Center(
        child: Text("Data user tidak ditemukan"),
      );
    }

    final user = snapshot.data!;

    return Column(
      children: [
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          user.email,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Find balance in motion, harmony in stillness.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
            ),
          ),
        ),

        const SizedBox(height: 28),
      ],
    );
  },
),
              //================ STATS =================
              Row(
                children: [
                  Expanded(
                    child: ProfileStatCard(
                      icon: Icons.local_fire_department,
                      iconColor: const Color(0xff4F7F5D),
                      value: "14",
                      label: "DAY STREAK",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ProfileStatCard(
                      icon: Icons.water_drop,
                      iconColor: Colors.blue,
                      value: "2.4L",
                      label: "AVG DAILY",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProfileStatCard(
                icon: Icons.show_chart,
                iconColor: const Color(0xff35694A),
                value: "12,450",
                label: "STEPS TODAY",
                bottomWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const LinearProgressIndicator(
                    value: .78,
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              //================ ACCOUNT SETTINGS =================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PENGATURAN AKUN",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileSettingTile(
  icon: Icons.person_add_alt_1,
  title: "Edit Profil",
  subtitle: "Nama, foto, dan data fisik",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EditProfileScreen(),
      ),
    );
  },
),
                    const Divider(),
                    ProfileSettingTile(
                      icon: Icons.lock_outline,
                      title: "Keamanan Akun",
                      subtitle: "Ganti password & email",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              //================ APP SETTINGS =================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PENGATURAN APLIKASI",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileSettingTile(
                      icon: Icons.track_changes,
                      title: "Target Harian",
                      subtitle: "Steps, Water, Mindfulness",
                      onTap: () {},
                    ),
                    const Divider(),
                    ProfileSettingTile(
                      icon: Icons.notifications_none,
                      title: "Notifikasi",
                      subtitle: "Reminders & Updates",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Konektivitas section (Privasi & Izin Data, Perangkat
              // Terhubung) removed per request.

              //================ LOG OUT =================
              SizedBox(
                width: 200,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () async {
  await AuthService().logout();

  if (!context.mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ),
    (route) => false,
  );
},
                  icon: const Icon(Icons.logout, color: Colors.red, size: 20),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFDADA),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}