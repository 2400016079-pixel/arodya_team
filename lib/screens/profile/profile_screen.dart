import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

      // PERBAIKAN: Memindahkan bottomNavigationBar ke level Scaffold (di luar body)
      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
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
                MaterialPageRoute(builder: (_) => const StatisticsScreen()),
              );
              break;
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              //================ HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ZenFit",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff35694A),
                    ),
                  ),
                  const Icon(Icons.person_outline, size: 32),
                ],
              ),
              const SizedBox(height: 40),

              //================ PROFILE =================
              Stack(
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: const Color(0xffE5EFE8),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    bottom: 8,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xff4F7F5D),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "rosiana",
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "Find balance in motion, harmony in stillness.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              const SizedBox(height: 40),

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
                  const SizedBox(width: 18),
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
              const SizedBox(height: 22),
              ProfileStatCard(
                icon: Icons.show_chart,
                iconColor: const Color(0xff35694A),
                value: "12,450",
                label: "STEPS TODAY",
                bottomWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const LinearProgressIndicator(
                    value: .78,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              //================ ACCOUNT SETTINGS =================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PENGATURAN AKUN",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileSettingTile(
                      icon: Icons.person_add_alt_1,
                      title: "Edit Profil",
                      subtitle: "Nama, foto, dan data fisik",
                      onTap: () {},
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
              const SizedBox(height: 35),

              //================ APP SETTINGS =================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PENGATURAN APLIKASI",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
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
              const SizedBox(height: 35),

              //================ CONNECTIVITY =================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "KONEKTIVITAS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileSettingTile(
                      icon: Icons.verified_user_outlined,
                      title: "Privasi & Izin Data",
                      subtitle: "Data sharing & permissions",
                      onTap: () {},
                    ),
                    const Divider(),
                    ProfileSettingTile(
                      icon: Icons.devices_other_outlined,
                      title: "Perangkat Terhubung",
                      subtitle: "Google Fit / Apple Health",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              //================ LOG OUT =================
              SizedBox(
                width: 220,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFDADA),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Jarak aman di bawah tombol Log Out
            ],
          ),
        ),
      ),
    );
  }
}
