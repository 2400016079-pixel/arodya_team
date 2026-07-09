import 'package:flutter/material.dart';

import '../../models/activity_model.dart';
import '../../services/activity_service.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/stats_summary_tile.dart';
import '../activity/activity_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../water/water_screen.dart';
import '../mood/mood_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;
    final hPad = size.width * 0.055;

    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 4) return;

          Widget targetScreen;
          switch (index) {
            case 0:
              targetScreen = DashboardScreen();
              break;
            case 1:
              targetScreen = const ActivityScreen();
              break;
            case 2:
              targetScreen = const WaterScreen();
              break;
            case 3:
              targetScreen = const MoodScreen();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================ HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.person_outline, size: isSmall ? 24 : 28),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xff35694A),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Icon(
                          Icons.self_improvement,
                          color: Colors.white,
                          size: 16,
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
                  Icon(Icons.notifications_none, size: isSmall ? 24 : 28),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                "Stats",
                style: TextStyle(
                  fontSize: isSmall ? 32 : 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Your progress this week.",
                style: TextStyle(
                  fontSize: isSmall ? 14 : 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              //================ TAB =================
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(child: _tabButton("Week", 0)),
                    Expanded(child: _tabButton("Month", 1)),
                    Expanded(child: _tabButton("Year", 2)),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              //================ ACTIVITY SCORE =================
              StatCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Activity Score",
                          style: TextStyle(
                            fontSize: isSmall ? 17 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xffEDF5EF),
                          child: Icon(
                            Icons.bar_chart,
                            color: Colors.green.shade700,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Text(
                          "84",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff35694A),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEDF5EF),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 15,
                                color: Color(0xff35694A),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "+12%",
                                style: TextStyle(
                                  color: Color(0xff35694A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      height: 170,
                      child: CustomPaint(
                        size: const Size(double.infinity, 170),
                        painter: _LineChartPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //================ MOOD =================
              StatCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mood",
                          style: TextStyle(
                            fontSize: isSmall ? 17 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.self_improvement,
                          color: Colors.green.shade700,
                          size: 22,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: isSmall ? 130 : 150,
                            height: isSmall ? 130 : 150,
                            child: const CircularProgressIndicator(
                              value: .55,
                              strokeWidth: 14,
                              color: Color(0xff4F7F5D),
                              backgroundColor: Color(0xffDDE8E1),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "55%",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Calm",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    _legend(const Color(0xff4F7F5D), "Calm", "14 hrs"),
                    const SizedBox(height: 12),
                    _legend(const Color(0xff9DD5AB), "Energetic", "7 hrs"),
                    const SizedBox(height: 12),
                    _legend(const Color(0xffDDE8E1), "Stressed", "3 hrs"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //================ SUMMARY =================
              const StatsSummaryTile(
                icon: Icons.water_drop,
                iconBg: Color(0xffDCEBFF),
                iconColor: Color(0xff2E6EA8),
                title: "Hydration",
                value: "2.4",
                unit: "L/day",
              ),
              const SizedBox(height: 14),
              const StatsSummaryTile(
                icon: Icons.fitness_center,
                iconBg: Color(0xffDDF5E8),
                iconColor: Color(0xff4F7F5D),
                title: "Total Workouts",
                value: "142",
                unit: "times",
              ),
              const SizedBox(height: 14),
              const StatsSummaryTile(
                icon: Icons.nightlight_round,
                iconBg: Color(0xffECECEC),
                iconColor: Colors.blueGrey,
                title: "Sleep",
                value: "7.2",
                unit: "hr/night",
              ),

              const SizedBox(height: 30),

              Text(
                "Activity History",
                style: TextStyle(
                  fontSize: isSmall ? 20 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              StreamBuilder<List<ActivityModel>>(
                stream: ActivityService().getActivities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Belum ada activity"));
                  }

                  final activities = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final item = activities[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.fitness_center, size: 20),
                          ),
                          title: Text(
                            item.activity,
                            style: const TextStyle(fontSize: 15),
                          ),
                          subtitle: Text(
                            "${item.duration} menit\n"
                            "${item.intensity}\n"
                            "${item.date.day}/${item.date.month}/${item.date.year}",
                            style: const TextStyle(fontSize: 13),
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 22,
                            ),
                            onPressed: () async {
                              await ActivityService().deleteActivity(item.id!);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final selected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xff35694A) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _legend(Color color, String title, String value) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 10),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
        Text(
          value,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
