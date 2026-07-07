import 'package:flutter/material.dart';

import '../../models/activity_model.dart';
import '../../services/activity_service.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/stats_summary_tile.dart';
import '../activity/activity_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../water/water_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return; // Mencegah navigasi ulang ke diri sendiri

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
            default:
              return;
          }

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => targetScreen,
              transitionDuration: Duration
                  .zero, // Transisi instan agar terasa seperti tab bar sungguhan
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================ HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.person_outline, size: 30),
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xff35694A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.self_improvement,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "ZenFit",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff35694A),
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none, size: 30),
                ],
              ),
              const SizedBox(height: 35),
              const Text(
                "Stats",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your progress this week.",
                style: TextStyle(fontSize: 22, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              //================ TAB =================
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _tabButton("Week", 0),
                    _tabButton("Month", 1),
                    _tabButton("Year", 2),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              //================ ACTIVITY SCORE =================
              StatCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Activity Score",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: const Color(0xffEDF5EF),
                          child: Icon(
                            Icons.bar_chart,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Text(
                          "84",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff35694A),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEDF5EF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 18,
                                color: Color(0xff35694A),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "+12%",
                                style: TextStyle(
                                  color: Color(0xff35694A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 220,
                      child: CustomPaint(
                        size: const Size(double.infinity, 220),
                        painter: _LineChartPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              //================ MOOD =================
              StatCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Mood",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.self_improvement,
                          color: Colors.green.shade700,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: .55,
                              strokeWidth: 18,
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
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Calm",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    _legend(const Color(0xff4F7F5D), "Calm", "14 hrs"),
                    const SizedBox(height: 15),
                    _legend(const Color(0xff9DD5AB), "Energetic", "7 hrs"),
                    const SizedBox(height: 15),
                    _legend(const Color(0xffDDE8E1), "Stressed", "3 hrs"),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              //================ SUMMARY =================
              const StatsSummaryTile(
                icon: Icons.water_drop,
                iconBg: Color(0xffDCEBFF),
                iconColor: Color(0xff2E6EA8),
                title: "Hydration",
                value: "2.4",
                unit: "L/day",
              ),
              const SizedBox(height: 20),
              const StatsSummaryTile(
                icon: Icons.fitness_center,
                iconBg: Color(0xffDDF5E8),
                iconColor: Color(0xff4F7F5D),
                title: "Total Workouts",
                value: "142",
                unit: "times",
              ),
              const SizedBox(height: 20),
const StatsSummaryTile(
  icon: Icons.nightlight_round,
  iconBg: Color(0xffECECEC),
  iconColor: Colors.blueGrey,
  title: "Sleep",
  value: "7.2",
  unit: "hr/night",
),

const SizedBox(height: 40),

const Text(
  "Activity History",
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 20),

StreamBuilder<List<ActivityModel>>(
  stream: ActivityService().getActivities(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(
        child: Text("Belum ada activity"),
      );
    }

    final activities = snapshot.data!;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final item = activities[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.fitness_center),
            ),
            title: Text(item.activity),
            subtitle: Text(
              "${item.duration} menit\n"
              "${item.intensity}\n"
              "${item.date.day}/${item.date.month}/${item.date.year}",
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
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

const SizedBox(height: 40),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xff35694A) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
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
        CircleAvatar(radius: 7, backgroundColor: color),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 20))),
        Text(
          value,
          style: const TextStyle(color: Colors.black54, fontSize: 18),
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
