import 'package:flutter/material.dart';

import '../../widgets/activity_item.dart';
import '../../widgets/bottom_navbar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int selectedActivity = 0;
  double duration = 45;

  final dateController = TextEditingController(text: "10/27/2026");
  final intensityController = TextEditingController(text: "Moderate Flow");
  final notesController = TextEditingController();

  // Menambahkan dispose untuk membersihkan controller dari memori
  @override
  void dispose() {
    dateController.dispose();
    intensityController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
      // BODY UTAMA
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
                          color: const Color(0xff4F7F5D),
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

              const SizedBox(height: 35),

              const Text(
                "Log Activity",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "What did you practice today?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 35),
              
              //================ ACTIVITY GRID =================
              Wrap(
                spacing: 18,
                runSpacing: 18,
                children: [
                  ActivityItem(
                    icon: Icons.directions_walk,
                    title: "Walking",
                    selected: selectedActivity == 0,
                    onTap: () {
                      setState(() {
                        selectedActivity = 0;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.directions_run,
                    title: "Running",
                    selected: selectedActivity == 1,
                    onTap: () {
                      setState(() {
                        selectedActivity = 1;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.pedal_bike,
                    title: "Cycling",
                    selected: selectedActivity == 2,
                    onTap: () {
                      setState(() {
                        selectedActivity = 2;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.self_improvement,
                    title: "Yoga",
                    selected: selectedActivity == 3,
                    onTap: () {
                      setState(() {
                        selectedActivity = 3;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.pool,
                    title: "Swimming",
                    selected: selectedActivity == 4,
                    onTap: () {
                      setState(() {
                        selectedActivity = 4;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.fitness_center,
                    title: "Weights",
                    selected: selectedActivity == 5,
                    onTap: () {
                      setState(() {
                        selectedActivity = 5;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.timer,
                    title: "HIIT",
                    selected: selectedActivity == 6,
                    onTap: () {
                      setState(() {
                        selectedActivity = 6;
                      });
                    },
                  ),
                  ActivityItem(
                    icon: Icons.accessibility_new,
                    title: "Pilates",
                    selected: selectedActivity == 7,
                    onTap: () {
                      setState(() {
                        selectedActivity = 7;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 35),

              //================ FORM CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Duration",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                        Text(
                          "${duration.round()} min",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff35694A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Slider(
                      value: duration,
                      min: 5,
                      max: 180,
                      activeColor: const Color(0xff5A845F),
                      onChanged: (value) {
                        setState(() {
                          duration = value;
                        });
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("5m"),
                        Text("3h"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    
                    //================ DATE =================
                    const Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    //================ INTENSITY =================
                    const Text(
                      "Intensity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: intensityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    //================ NOTES =================
                    const Text(
                      "Mindful Notes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notesController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "How did you feel during this movement?",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              //================ BUTTON CANCEL =================
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xff35694A),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff35694A),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //================ BUTTON SAVE =================
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Activity Saved"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A845F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Save Activity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              
              // Memberikan jarak bawah agar tidak tertutup navbar
              const SizedBox(height: 40), 
            ],
          ),
        ),
      ),
      
      // BOTTOM NAVBAR DILETAKKAN DI SINI (Properti langsung dari Scaffold)
      bottomNavigationBar: BottomNavbar(
        currentIndex: 1,
        onTap: (index) {
          // Aksi ketika navbar ditekan
        },
      ),
    );
  }
}