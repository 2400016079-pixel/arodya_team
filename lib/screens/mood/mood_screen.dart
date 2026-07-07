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

  // Mematikan controller saat screen ditutup untuk menghindari memory leak
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
      // PERBAIKAN 1: Pindahkan bottomNavigationBar ke sini (properti milik Scaffold)
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
              break; // sudah di halaman Mood

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

              const SizedBox(height: 45),

              const Center(
                child: Text(
                  "How are you\nfeeling?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4F7F5D),
                    height: 1.1,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Center(
                child: Text(
                  "Take a moment to check in with yourself.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 35),

              //================ MOOD CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
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
                          "Pilih Perasaan",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Hari Ini",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MoodCard(
                            icon: Icons.sentiment_very_satisfied,
                            title: "Senang",
                            selected: selectedMood == 0,
                            onTap: () {
                              setState(() {
                                selectedMood = 0;
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          MoodCard(
                            icon: Icons.sentiment_satisfied,
                            title: "Tenang",
                            selected: selectedMood == 1,
                            onTap: () {
                              setState(() {
                                selectedMood = 1;
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          MoodCard(
                            icon: Icons.sentiment_neutral,
                            title: "Biasa",
                            selected: selectedMood == 2,
                            onTap: () {
                              setState(() {
                                selectedMood = 2;
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          MoodCard(
                            icon: Icons.sentiment_dissatisfied,
                            title: "Sedih",
                            selected: selectedMood == 3,
                            onTap: () {
                              setState(() {
                                selectedMood = 3;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              //================ ADD NOTE =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
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
                      "Add a note (optional)",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4F7F5D),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: noteController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "What's making you feel this way?",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 45),

              //================ FACTORS =================
              const Text(
                "Factors",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4F7F5D),
                ),
              ),

              const SizedBox(height: 22),

              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  FactorChip(
                    title: "Work",
                    selected: selectedFactor == 0,
                    onTap: () {
                      setState(() {
                        selectedFactor = 0;
                      });
                    },
                  ),
                  FactorChip(
                    title: "Sleep",
                    selected: selectedFactor == 1,
                    onTap: () {
                      setState(() {
                        selectedFactor = 1;
                      });
                    },
                  ),
                  FactorChip(
                    title: "Exercise",
                    selected: selectedFactor == 2,
                    onTap: () {
                      setState(() {
                        selectedFactor = 2;
                      });
                    },
                  ),
                  FactorChip(
                    title: "Family",
                    selected: selectedFactor == 3,
                    onTap: () {
                      setState(() {
                        selectedFactor = 3;
                      });
                    },
                  ),
                  FactorChip(
                    title: "Health",
                    selected: selectedFactor == 4,
                    onTap: () {
                      setState(() {
                        selectedFactor = 4;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: const Icon(Icons.add, size: 30),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              //================ SAVE BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Mood berhasil disimpan")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A845F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    "Save Entry",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // PERBAIKAN 2: Jarak SizedBox bawah dikurangi sedikit agar pas dengan layout
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
