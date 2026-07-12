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
import '../../models/water_model.dart';

import '../../services/auth_service.dart';
import '../../services/water_service.dart';

import '../../models/mood_model.dart';
import '../../services/mood_service.dart';

import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int selectedTab = 0;

  Map<String, int> _countMoods(List<MoodModel> moods) {
  final Map<String, int> result = {};

  for (final mood in moods) {
    result[mood.mood] = (result[mood.mood] ?? 0) + 1;
  }

  return result;
}

  double _calculateScore(List<ActivityModel> activities) {
    final now = DateTime.now();

    final weekActivities = activities.where((a) {
      return now.difference(a.date).inDays < 7;
    }).toList();

    int totalMinutes = 0;

    for (final activity in weekActivities) {
      totalMinutes += activity.duration;
    }

    return (totalMinutes / 300 * 100).clamp(0, 100);
  }

  double _calculateHydration(List<WaterModel> waters) {
  int totalMl = 0;

  for (final water in waters) {
    totalMl += water.amount;
  }

  return totalMl / 1000;
}

  List<FlSpot> _getChartSpots(List<ActivityModel> activities) {
  final now = DateTime.now();

  if (selectedTab == 0) {
    // WEEK
    List<double> minutes = List.filled(7, 0);

    for (final activity in activities) {
      final diff = now.difference(activity.date).inDays;

      if (diff >= 0 && diff < 7) {
        minutes[6 - diff] += activity.duration;
      }
    }

    return List.generate(
      7,
      (i) => FlSpot(i.toDouble(), minutes[i]),
    );
  }

  if (selectedTab == 1) {
    // MONTH
    List<double> minutes = List.filled(30, 0);

    for (final activity in activities) {
      final diff = now.difference(activity.date).inDays;

      if (diff >= 0 && diff < 30) {
        minutes[29 - diff] += activity.duration;
      }
    }

    return List.generate(
      30,
      (i) => FlSpot(i.toDouble(), minutes[i]),
    );
  }

  // YEAR
  List<double> months = List.filled(12, 0);

  for (final activity in activities) {
    if (activity.date.year == now.year) {
      months[activity.date.month - 1] += activity.duration;
    }
  }

  return List.generate(
    12,
    (i) => FlSpot(i.toDouble(), months[i]),
  );
}

  List<ActivityModel> _filterActivities(List<ActivityModel> activities) {
  final now = DateTime.now();

  return activities.where((activity) {
    final days = now.difference(activity.date).inDays;

    switch (selectedTab) {
      case 0: // Week
        return days < 7;

      case 1: // Month
        return days < 30;

      case 2: // Year
        return days < 365;

      default:
        return true;
    }
  }).toList();
}

List<WaterModel> _filterWaters(List<WaterModel> waters) {
  final now = DateTime.now();

  return waters.where((water) {
    final days = now.difference(water.date).inDays;

    switch (selectedTab) {
      case 0: // Week
        return days < 7;

      case 1: // Month
        return days < 30;

      case 2: // Year
        return days < 365;

      default:
        return true;
    }
  }).toList();
}

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
                   StreamBuilder<List<ActivityModel>>(
  stream: ActivityService().getActivities(),
  builder: (context, snapshot) {
   final allActivities = snapshot.data ?? [];

final activities = _filterActivities(allActivities);

final score = _calculateScore(activities);

final total = activities.length;

    return Row(
      children: [
        Text(
  score.toInt().toString(),
  style: const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xff35694A),
  ),
),

        const SizedBox(width: 10),

        Expanded(
  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    decoration: BoxDecoration(
      color: const Color(0xffEDF5EF),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.trending_up,
          size: 15,
          color: Color(0xff35694A),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            "$total Activity",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff35694A),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  ),
),
      ],
    );
  },
),
                    const SizedBox(height: 22),
                    SizedBox(
  height: 200,
  child: StreamBuilder<List<ActivityModel>>(
    stream: ActivityService().getActivities(),
    builder: (context, snapshot) {
      final activities = snapshot.data ?? [];

      return LineChart(
        LineChartData(
          minX: 0,
          maxX: selectedTab == 0
    ? 6
    : selectedTab == 1
        ? 29
        : 11,
          minY: 0,
          maxY: 120,

          gridData: FlGridData(show: true),

          borderData: FlBorderData(show: false),

          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 28,
                showTitles: true,
              ),
            ),
            bottomTitles: AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      if (selectedTab == 0) {
        const days = ["M", "S", "S", "R", "K", "J", "S"];

        return Text(
          days[value.toInt()],
          style: const TextStyle(fontSize: 12),
        );
      }

      if (selectedTab == 1) {
        if (value.toInt() % 5 != 0) {
          return const SizedBox();
        }

        return Text(
          "${value.toInt() + 1}",
          style: const TextStyle(fontSize: 10),
        );
      }

      const months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "Mei",
        "Jun",
        "Jul",
        "Agu",
        "Sep",
        "Okt",
        "Nov",
        "Des",
      ];

      return Text(
        months[value.toInt()],
        style: const TextStyle(fontSize: 10),
      );
    },
  ),
),
          ),

          lineBarsData: [
            LineChartBarData(
             spots: _getChartSpots(activities),
              isCurved: true,
              color: const Color(0xff35694A),
              barWidth: 4,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      );
    },
  ),
),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //================ MOOD =================
StatCard(
  child: StreamBuilder<List<MoodModel>>(
    stream: MoodService().getMoods(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          height: 250,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const SizedBox(
          height: 250,
          child: Center(
            child: Text("Belum ada data mood"),
          ),
        );
      }

      final moods = snapshot.data!;

      final counts = _countMoods(moods);

      final sorted = counts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final topMood = sorted.first;

      final percent = topMood.value / moods.length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
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
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 14,
                    color: const Color(0xff4F7F5D),
                    backgroundColor: const Color(0xffDDE8E1),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${(percent * 100).round()}%",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      topMood.key,
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

          ...sorted.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _legend(
                const Color(0xff4F7F5D),
                e.key,
                "${e.value}x",
              ),
            ),
          ),
        ],
      );
    },
  ),
),

const SizedBox(height: 20),

              //================ SUMMARY =================
              StreamBuilder<List<WaterModel>>(
  stream: WaterService().getWaterHistory(AuthService().currentUser!.uid),
  builder: (context, snapshot) {
    final waters = _filterWaters(snapshot.data ?? []);

    int total = 0;

    for (final water in waters) {
      total += water.amount;
    }

    return StatsSummaryTile(
      icon: Icons.water_drop,
      iconBg: const Color(0xffDCEBFF),
      iconColor: const Color(0xff2E6EA8),
      title: "Hydration",
      value: (total / 1000).toStringAsFixed(1),
      unit: "L",
    );
  },
),
              const SizedBox(height: 14),
              StreamBuilder<List<ActivityModel>>(
  stream: ActivityService().getActivities(),
  builder: (context, snapshot) {

    final activities = _filterActivities(snapshot.data ?? []);

    final totalWorkout = activities.length;

    return StatsSummaryTile(
      icon: Icons.fitness_center,
      iconBg: const Color(0xffDDF5E8),
      iconColor: const Color(0xff4F7F5D),
      title: "Total Workouts",
      value: totalWorkout.toString(),
      unit: "times",
    );
  },
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

                  final activities = _filterActivities(snapshot.data!);

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