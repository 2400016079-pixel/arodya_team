import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../activity/activity_screen.dart';
import '../water/water_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Statistics",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            _buildStatistic(
              Icons.accessibility,
              Colors.blue,
              "Total Workouts",
              "142 times",
            ),

            const Divider(),

            _buildStatistic(
              Icons.water_drop,
              Colors.blue,
              "Total Water",
              "84,000 ml",
            ),

            const Divider(),

            _buildStatistic(
              Icons.sentiment_satisfied_alt,
              Colors.orange,
              "Most Frequent Mood",
              "Balanced & Calm",
            ),

            const SizedBox(height: 40),

            const Center(
              child: Text(
                "Weekly Activity",

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 250,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  _bar(120, "M"),

                  _bar(180, "T"),

                  _bar(90, "W"),

                  _bar(0, "T"),

                  _bar(0, "F"),

                  _bar(0, "Ú"),

                  _bar(0, "Ú"),
                ],
              ),
            ),

            const SizedBox(height: 45),

            const Text(
              "Insights",

              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _insightCard(
              Icons.trending_up,

              "Streak Konsistensi",

              "Kamu sudah aktif selama 5 hari berturut-turut. Jaga momentum santai ini untuk mencapai target mingguan!",
            ),

            const SizedBox(height: 20),
            _insightCard(
              Icons.bed,
              "Istirahat & Pemulihan",
              "Kemarin adalah hari dengan intensitas tinggi. Pertimbangkan untuk melakukan sesi yoga restoratif atau jalan santai hari ini.",
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff0C9E6E),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
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
              // Sudah di Statistics
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: "Activity",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: "Water"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Stats"),
        ],
      ),
    );
  }

  Widget _buildStatistic(
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: color, size: 38),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.black54, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(double height, String day) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 42,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xff013220),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 12),
        Text(day, style: const TextStyle(fontSize: 18, color: Colors.black54)),
      ],
    );
  }

  Widget _insightCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xffE5E5E5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xffEDF7F1),
            child: Icon(icon, color: const Color(0xff013220), size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
