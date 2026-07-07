import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth_service.dart';
import '../../services/activity_service.dart';
import '../../models/activity_model.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/history_tile.dart';
import '../../widgets/weekly_bar.dart';

import '../activity/activity_screen.dart';
import '../auth/login_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/notification_screen.dart';
import '../statistics/statistics_screen.dart';
import '../water/add_drink_screen.dart';
import '../water/water_screen.dart';
import '../mood/mood_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ActivityScreen()),
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
                  // PERBAIKAN: dulu cuma nampilin snackbar, sekarang beneran ke MoodScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MoodScreen()),
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
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;
    final hPad = size.width * 0.055;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================ HEADER ================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.person_outline, size: isSmall ? 26 : 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xff35694A),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Icon(
                                Icons.self_improvement,
                                color: Colors.white,
                                size: isSmall ? 16 : 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "ZenFit",
                              style: TextStyle(
                                fontSize: isSmall ? 18 : 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff35694A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      if (value == "notification") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      }

                      if (value == "logout") {
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
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: "notification",
                        child: Text("Notification"),
                      ),
                      PopupMenuItem(value: "logout", child: Text("Logout")),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Text(
                "Good Morning,\n${user?.displayName ?? user?.email ?? 'User'} 👋",
                style: TextStyle(
                  fontSize: isSmall ? 26 : 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Your daily wellness summary is ready.",
                style: TextStyle(
                  fontSize: isSmall ? 14 : 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 26),

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
                        minHeight: 8,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Color(0xff2C6C72)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "0 L",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        Text(
                          "2.5 L",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              //================ ACTIVITY ================
              StreamBuilder<List<ActivityModel>>(
                stream: ActivityService().getActivities(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const DashboardCard(
                      icon: Icons.directions_run,
                      iconBackground: Color(0xffDDEBDD),
                      iconColor: Color(0xff35694A),
                      title: "Activity Tracker",
                      value: "0 Min",
                      subtitle: "Belum ada activity",
                      backgroundColor: Color(0xffEDF5EF),
                      borderColor: Color(0xffD3E3D7),
                    );
                  }

                  final activities = snapshot.data!;
                  final latest = activities.first;

                  final totalMinutes = activities.fold<int>(
                    0,
                    (sum, item) => sum + item.duration,
                  );

                  return DashboardCard(
                    icon: Icons.directions_run,
                    iconBackground: const Color(0xffDDEBDD),
                    iconColor: const Color(0xff35694A),
                    title: "Activity Tracker",
                    value: "$totalMinutes Min",
                    subtitle: latest.activity,
                    backgroundColor: const Color(0xffEDF5EF),
                    borderColor: const Color(0xffD3E3D7),
                  );
                },
              ),

              const SizedBox(height: 16),

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

              const SizedBox(height: 28),

              //================ HISTORY =================
              Text(
                "History Activity",
                style: TextStyle(
                  fontSize: isSmall ? 19 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              StreamBuilder<List<ActivityModel>>(
                stream: ActivityService().getActivities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Text("Belum ada activity")),
                    );
                  }

                  final activities = snapshot.data!;

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activities.length > 5 ? 5 : activities.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = activities[index];

                        return HistoryTile(
                          icon: Icons.directions_run,
                          iconColor: const Color(0xff35694A),
                          iconBackground: const Color(0xffEAF5EC),
                          title: item.activity,
                          subtitle:
                              "${item.date.day}/${item.date.month}/${item.date.year} • ${item.duration} Minutes",
                          trailing: item.intensity,
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              //================ WEEKLY STATISTICS =================
              Text(
                "Weekly Statistics",
                style: TextStyle(
                  fontSize: isSmall ? 19 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              StreamBuilder<List<ActivityModel>>(
                stream: ActivityService().getActivities(),
                builder: (context, snapshot) {
                  final heights = List<double>.filled(7, 16);

                  if (snapshot.hasData) {
                    for (var item in snapshot.data!) {
                      final day = item.date.weekday - 1;
                      heights[day] += item.duration.toDouble();

                      if (heights[day] > 130) {
                        heights[day] = 130;
                      }
                    }
                  }

                  return SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        WeeklyBar(height: heights[0], day: "Mon"),
                        WeeklyBar(height: heights[1], day: "Tue"),
                        WeeklyBar(height: heights[2], day: "Wed"),
                        WeeklyBar(height: heights[3], day: "Thu"),
                        WeeklyBar(height: heights[4], day: "Fri"),
                        WeeklyBar(height: heights[5], day: "Sat"),
                        WeeklyBar(height: heights[6], day: "Sun"),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              //================ BUTTON NEW ACTIVITY =================
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => _openQuickAddSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff35694A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                  label: const Text(
                    "New Activity",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),

              const SizedBox(height: 24),
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

          switch (index) {
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
                MaterialPageRoute(builder: (_) => const MoodScreen()),
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
    );
  }
}
