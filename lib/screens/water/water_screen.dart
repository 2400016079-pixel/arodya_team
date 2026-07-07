import 'package:flutter/material.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/water_option.dart';
import '../../widgets/water_history_tile.dart';
import 'add_drink_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../activity/activity_screen.dart';
import '../mood/mood_screen.dart';
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
  int selectedQuickAdd = -1;

  final int targetMl = 2000;
  int consumedMl = 1200;

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

  void _addWater(
    int amount, {
    IconData icon = Icons.water_drop,
    String title = "Air",
  }) {
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

    if (result is Map && result["amount"] != null) {
      _addWater(
        result["amount"] as int,
        title: (result["drinkType"] as String?) ?? "Minuman",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;
    final hPad = size.width * 0.055;
    // Diameter lingkaran progress ikut lebar layar, dikasih batas atas
    // biar di tablet ga jadi raksasa.
    final ringSize = (size.width * 0.62).clamp(200.0, 260.0);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff35694A),
        onPressed: _openAddDrinkScreen,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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

              const SizedBox(height: 28),

              Text(
                "Target Hidrasi Harian",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmall ? 24 : 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Tetap terhidrasi untuk menjaga fokus dan\nketenangan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmall ? 13 : 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 30),

              //================ PROGRESS =================
              Container(
                width: ringSize,
                height: ringSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xff5A84AC), width: 14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 32,
                      color: Color(0xff35694A),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$consumedMl",
                              style: const TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff7A9ABB),
                              ),
                            ),
                            const TextSpan(
                              text: " ml",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff7A9ABB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "/ $targetMl ml",
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffEDF5EF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: Color(0xff5A845F),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Kamu mencapai $percent% dari target hari ini",
                        style: const TextStyle(
                          color: Color(0xff6C9275),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              //================ QUICK ADD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tambah Cepat",
                      style: TextStyle(
                        fontSize: isSmall ? 18 : 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: WaterOption(
                            icon: Icons.local_cafe_outlined,
                            amount: "250 ml",
                            selected: selectedQuickAdd == 0,
                            onTap: () {
                              setState(() => selectedQuickAdd = 0);
                              _addWater(
                                250,
                                icon: Icons.local_cafe_outlined,
                                title: "Air",
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: WaterOption(
                            icon: Icons.local_drink_outlined,
                            amount: "500 ml",
                            selected: selectedQuickAdd == 1,
                            onTap: () {
                              setState(() => selectedQuickAdd = 1);
                              _addWater(
                                500,
                                icon: Icons.local_drink_outlined,
                                title: "Air",
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: WaterOption(
                            icon: Icons.blender_outlined,
                            amount: "750 ml",
                            selected: selectedQuickAdd == 2,
                            onTap: () {
                              setState(() => selectedQuickAdd = 2);
                              _addWater(
                                750,
                                icon: Icons.blender_outlined,
                                title: "Air",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              //================ HISTORY =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Riwayat Hari Ini",
                            style: TextStyle(
                              fontSize: isSmall ? 16 : 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            "Lihat Semua",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff35694A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
