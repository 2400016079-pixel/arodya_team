import 'package:flutter/material.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/water_option.dart';
import '../../widgets/water_history_tile.dart';
import 'add_drink_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../activity/activity_screen.dart';
import '../statistics/statistics_screen.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _HistoryEntry {
  final IconData icon;
  final String title;
  final String time;
  final int amount;

  _HistoryEntry({
    required this.icon,
    required this.title,
    required this.time,
    required this.amount,
  });
}

class _WaterScreenState extends State<WaterScreen> {
  // Renamed from "selectedIndex" to avoid confusion with the bottom
  // navbar's own currentIndex — they used to share the same name even
  // though they track two unrelated things.
  int selectedQuickAdd = -1;

  final int targetMl = 2000;
  int consumedMl = 1200; // starting point so the 60% message is accurate

  final List<_HistoryEntry> history = [
    _HistoryEntry(
      icon: Icons.local_drink,
      title: "Air Mineral",
      time: "09:30 AM",
      amount: 500,
    ),
    _HistoryEntry(
      icon: Icons.local_cafe,
      title: "Teh Hijau",
      time: "07:15 AM",
      amount: 250,
    ),
  ];

  int get percent =>
      targetMl == 0 ? 0 : ((consumedMl / targetMl) * 100).clamp(0, 100).round();

  void _addWater(int amount, {IconData icon = Icons.water_drop, String title = "Air"}) {
    setState(() {
      consumedMl = (consumedMl + amount).clamp(0, targetMl * 2);
      history.insert(
        0,
        _HistoryEntry(
          icon: icon,
          title: title,
          time: TimeOfDay.now().format(context),
          amount: amount,
        ),
      );
    });
  }

  Future<void> _openAddDrinkScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDrinkScreen()),
    );

    // AddDrinkScreen now returns a map like
    // {"amount": 250, "drinkType": "Water", "temperature": "Normal"}
    // instead of nothing, so we can actually use it here.
    if (result is Map && result["amount"] != null) {
      _addWater(
        result["amount"] as int,
        title: (result["drinkType"] as String?) ?? "Minuman",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff35694A),
        onPressed: _openAddDrinkScreen,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 34,
        ),
      ),

      bottomNavigationBar: BottomNavbar(
  currentIndex: 2,
  onTap: (index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(),
          ),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ActivityScreen(),
          ),
        );
        break;

      case 2:
        break;

      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const StatisticsScreen(),
          ),
        );
        break;
    }
  },
),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //================ HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 30,
                  ),
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
                  const Icon(
                    Icons.notifications_none,
                    size: 30,
                  ),
                ],
              ),

              const SizedBox(height: 45),

              const Text(
                "Target Hidrasi Harian",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Tetap terhidrasi untuk menjaga fokus dan\nketenangan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              //================ PROGRESS =================
              Container(
                width: 330,
                height: 330,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff5A84AC),
                    width: 18,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 45,
                      color: Color(0xff35694A),
                    ),
                    const SizedBox(height: 18),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            // Was hardcoded to "2000" regardless of progress.
                            text: "$consumedMl",
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7A9ABB),
                            ),
                          ),
                          const TextSpan(
                            text: " ml",
                            style: TextStyle(
                              fontSize: 34,
                              color: Color(0xff7A9ABB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "/ $targetMl ml",
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffEDF5EF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: Color(0xff5A845F),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      // Was hardcoded to "60%" even though the circle above
                      // always showed 2000/2000 (100%). Now both use the
                      // same consumedMl/targetMl source.
                      "Kamu mencapai $percent% dari target hari ini",
                      style: const TextStyle(
                        color: Color(0xff6C9275),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              //================ QUICK ADD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tambah Cepat",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WaterOption(
                          icon: Icons.local_cafe_outlined,
                          amount: "250 ml",
                          selected: selectedQuickAdd == 0,
                          onTap: () {
                            setState(() => selectedQuickAdd = 0);
                            _addWater(250, icon: Icons.local_cafe_outlined, title: "Air");
                          },
                        ),
                        WaterOption(
                          icon: Icons.local_drink_outlined,
                          amount: "500 ml",
                          selected: selectedQuickAdd == 1,
                          onTap: () {
                            setState(() => selectedQuickAdd = 1);
                            _addWater(500, icon: Icons.local_drink_outlined, title: "Air");
                          },
                        ),
                        WaterOption(
                          icon: Icons.blender_outlined,
                          amount: "750 ml",
                          selected: selectedQuickAdd == 2,
                          onTap: () {
                            setState(() => selectedQuickAdd = 2);
                            _addWater(750, icon: Icons.blender_outlined, title: "Air");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              //================ HISTORY =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Riwayat Hari Ini",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lihat Semua",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff35694A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Was two hardcoded WaterHistoryTile widgets that never
                    // changed no matter what you added. Now built from the
                    // history list so quick-add and AddDrinkScreen entries
                    // actually show up.
                    for (int i = 0; i < history.length; i++) ...[
                      WaterHistoryTile(
                        icon: history[i].icon,
                        title: history[i].title,
                        time: history[i].time,
                        amount: "+${history[i].amount} ml",
                      ),
                      if (i != history.length - 1) const Divider(),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}