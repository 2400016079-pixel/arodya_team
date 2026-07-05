import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/menu_card.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/bottom_navbar.dart';

import '../activity/activity_screen.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';
import '../water/water_screen.dart';
import '../mood/mood_screen.dart';
import '../history/history_screen.dart';
import '../statistics/statistics_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xffDDF5E8),
                    child: Icon(
                      Icons.person,
                      color: Colors.green.shade700,
                      size: 32,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Selamat Datang 👋",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 5),

      Text(
        user?.email ?? "Selamat datang di ZenFit",
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    ],
  ),
),

                  Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
  ),
  child: IconButton(
    onPressed: () async {
      await _auth.logout();

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    },
    icon: const Icon(
      Icons.logout,
      size: 30,
    ),
  ),
),

                ],
              ),

              const SizedBox(height: 30),

              const SizedBox(height: 30),

              const Text(
                "Ringkasan Hari Ini",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              SummaryCard(
                icon: Icons.water_drop,
                iconColor: Colors.blue,
                iconBackground: const Color(0xffEAF2FF),
                title: "Air Hari Ini",
                value: "1.250 ml",
                subtitle: "Target 2.000 ml",
                bottomWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0.62,
                    minHeight: 8,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SummaryCard(
                icon: Icons.sentiment_satisfied_alt,
                iconColor: Colors.amber,
                iconBackground: const Color(0xffFFF9E7),
                title: "Mood Hari Ini",
                value: "Senang 😊",
                subtitle: "Tetap semangat!",
              ),

              const SizedBox(height: 15),

              SummaryCard(
                icon: Icons.directions_run,
                iconColor: Colors.deepOrange,
                iconBackground: const Color(0xffFFF3EA),
                title: "Aktivitas Hari Ini",
                value: "30 Menit",
                subtitle: "Jogging",
              ),

              const SizedBox(height: 30),

              const Text(
                "Menu Utama",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  MenuCard(
                    icon: Icons.directions_run,
                    title: "Activity\nTracker",
                    backgroundColor: const Color(0xff39D67C),
                    borderColor: const Color(0xff39D67C),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActivityScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.water_drop,
                    title: "Water\nReminder",
                    backgroundColor: const Color(0xffEAF4FF),
                    borderColor: const Color(0xff2196F3),
                    iconColor: Colors.blue,
                    textColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WaterScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.sentiment_satisfied_alt,
                    title: "Mood\nTracker",
                    backgroundColor: const Color(0xffFFFCEB),
                    borderColor: const Color(0xffFFD54F),
                    iconColor: Colors.amber,
                    textColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoodScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.history,
                    title: "History",
                    backgroundColor: const Color(0xffF5F2FF),
                    borderColor: const Color(0xff8A63FF),
                    iconColor: const Color(0xff8A63FF),
                    textColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.bar_chart,
                    title: "Statistik",
                    backgroundColor: const Color(0xffEEF6FF),
                    borderColor: const Color(0xff4A90E2),
                    iconColor: const Color(0xff4A90E2),
                    textColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StatisticsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Sudah di Dashboard
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ActivityScreen()),
              );
              break;

            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WaterScreen()),
              );
              break;

            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
