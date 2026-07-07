import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../activity/activity_screen.dart';
import '../water/water_screen.dart';
import '../statistics/statistics_screen.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/mood_card.dart';
import '../../widgets/factor_chip.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  int selectedMood = 1;
  int selectedFactor = 1;

  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;
    final hPad = size.width * 0.055; // padding horizontal proporsional

    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
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

              SizedBox(height: size.height * 0.035),

              Center(
                child: Text(
                  "How are you\nfeeling?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmall ? 32 : 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff4F7F5D),
                    height: 1.15,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  "Take a moment to check in with yourself.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 15,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              //================ MOOD CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pilih Perasaan",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            "Hari Ini",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Row + Expanded biar 4 mood pas satu baris, tanpa overflow
                    Row(
                      children: [
                        Expanded(
                          child: MoodCard(
                            icon: Icons.sentiment_very_satisfied,
                            title: "Senang",
                            selected: selectedMood == 0,
                            onTap: () => setState(() => selectedMood = 0),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MoodCard(
                            icon: Icons.sentiment_satisfied,
                            title: "Tenang",
                            selected: selectedMood == 1,
                            onTap: () => setState(() => selectedMood = 1),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MoodCard(
                            icon: Icons.sentiment_neutral,
                            title: "Biasa",
                            selected: selectedMood == 2,
                            onTap: () => setState(() => selectedMood = 2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MoodCard(
                            icon: Icons.sentiment_dissatisfied,
                            title: "Sedih",
                            selected: selectedMood == 3,
                            onTap: () => setState(() => selectedMood = 3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //================ ADD NOTE =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                    const Text(
                      "Add a note (optional)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4F7F5D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: noteController,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "What's making you feel this way?",
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        contentPadding: const EdgeInsets.all(14),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              //================ FACTORS =================
              const Text(
                "Factors",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4F7F5D),
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FactorChip(
                    title: "Work",
                    selected: selectedFactor == 0,
                    onTap: () => setState(() => selectedFactor = 0),
                  ),
                  FactorChip(
                    title: "Sleep",
                    selected: selectedFactor == 1,
                    onTap: () => setState(() => selectedFactor = 1),
                  ),
                  FactorChip(
                    title: "Exercise",
                    selected: selectedFactor == 2,
                    onTap: () => setState(() => selectedFactor = 2),
                  ),
                  FactorChip(
                    title: "Family",
                    selected: selectedFactor == 3,
                    onTap: () => setState(() => selectedFactor = 3),
                  ),
                  FactorChip(
                    title: "Health",
                    selected: selectedFactor == 4,
                    onTap: () => setState(() => selectedFactor = 4),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: const Icon(Icons.add, size: 22),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              //================ SAVE BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Mood berhasil disimpan")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A845F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Save Entry",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}