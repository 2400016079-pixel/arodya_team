import 'package:flutter/material.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/history_tile.dart';
import '../../widgets/weekly_bar.dart';
import '../activity/activity_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/notification_screen.dart';
import '../statistics/statistics_screen.dart';
import '../water/add_drink_screen.dart';
import '../water/water_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _openQuickAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.water_drop, color: Color(0xff2266A8)),
                title: const Text("Add Water"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDrinkScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.directions_run,
                  color: Color(0xff35694A),
                ),
                title: const Text("Log Activity"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Activity logging screen not built yet"),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.sentiment_satisfied,
                  color: Color(0xff35694A),
                ),
                title: const Text("Log Mood"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mood logging screen not built yet"),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================ HEADER ================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xff35694A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.self_improvement,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "ZenFit",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff35694A),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 35),

              const Text(
                "Good Morning,\nRosiana 👋",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your daily wellness summary is ready.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),

              const SizedBox(height: 35),

              //================ WATER REMINDER ================
              DashboardCard(
                icon: Icons.water_drop,
                iconBackground: const Color(0xffB8D8F5),
                iconColor: const Color(0xff2266A8),
                title: "Water Reminder",
                value: "1.2 L",
                subtitle: "Target 2.5 Liter",
                backgroundColor: const Color(0xffDCE8F2),
                borderColor: const Color(0xffBFD3E3),
                bottomWidget: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: const LinearProgressIndicator(
                        value: .48,
                        minHeight: 10,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Color(0xff2C6C72)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("0 L", style: TextStyle(color: Colors.black54)),
                        Text("2.5 L", style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //================ ACTIVITY ================
              const DashboardCard(
                icon: Icons.directions_run,
                iconBackground: Color(0xffDDEBDD),
                iconColor: Color(0xff35694A),
                title: "Activity Tracker",
                value: "45 Min",
                subtitle: "Jogging • +15% dari kemarin",
                backgroundColor: Color(0xffEDF5EF),
                borderColor: Color(0xffD3E3D7),
              ),

              const SizedBox(height: 20),

              //================ MOOD ================
              const DashboardCard(
                icon: Icons.sentiment_very_satisfied,
                iconBackground: Color(0xffE6F2E8),
                iconColor: Color(0xff35694A),
                title: "Mood Tracker",
                value: "😊",
                subtitle: "Feeling balanced and focused today",
                backgroundColor: Colors.white,
                borderColor: Color(0xffECECEC),
              ),

              const SizedBox(height: 35),

              //================ HISTORY =================
              const Text(
                "History Activity",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    HistoryTile(
                      icon: Icons.directions_run,
                      iconColor: Color(0xff35694A),
                      iconBackground: Color(0xffEAF5EC),
                      title: "Morning Run",
                      subtitle: "Today • 45 Minutes",
                      trailing: "320 kcal",
                    ),
                    Divider(),
                    HistoryTile(
                      icon: Icons.water_drop,
                      iconColor: Colors.blue,
                      iconBackground: Color(0xffEAF2FF),
                      title: "Drink Water",
                      subtitle: "Today • 500 ml",
                      trailing: "✔",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              //================ WEEKLY STATISTICS =================
              const Text(
                "Weekly Statistics",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              const SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WeeklyBar(height: 70, day: "Mon"),
                    WeeklyBar(height: 110, day: "Tue"),
                    WeeklyBar(height: 90, day: "Wed"),
                    WeeklyBar(height: 140, day: "Thu"),
                    WeeklyBar(height: 120, day: "Fri"),
                    WeeklyBar(height: 160, day: "Sat"),
                    WeeklyBar(height: 95, day: "Sun"),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              //================ BUTTON NEW ACTIVITY =================
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () => _openQuickAddSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff35694A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "New Activity",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff35694A),
        onPressed: () => _openQuickAddSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;

          Widget targetScreen;
          switch (index) {
            case 1:
              targetScreen = const ActivityScreen();
              break;
            case 2:
              targetScreen = const WaterScreen();
              break;
            case 3:
              targetScreen = const StatisticsScreen();
              break;
            default:
              return;
          }

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => targetScreen,
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      ),
    );
  }
}
