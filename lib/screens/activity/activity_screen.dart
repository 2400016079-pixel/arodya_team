import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/activity_model.dart';
import '../../services/activity_service.dart';

import '../../widgets/activity_item.dart';
import '../../widgets/bottom_navbar.dart';
import '../dashboard/dashboard_screen.dart';
import '../water/water_screen.dart';
import '../statistics/statistics_screen.dart';
import '../mood/mood_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int selectedActivity = 0;

  final List<String> activityList = [
    "Walking",
    "Running",
    "Cycling",
    "Yoga",
    "Swimming",
    "Weights",
    "HIIT",
    "Pilates",
  ];

  double duration = 45;

  DateTime selectedDate = DateTime.now();

  String selectedIntensity = "Sedang";

  final dateController = TextEditingController(
    text:
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
  );

  final notesController = TextEditingController();

  // Menambahkan dispose untuk membersihkan controller dari memori
  @override
  void dispose() {
    dateController.dispose();
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
                  const Icon(Icons.person_outline, size: 30),
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
                  const Icon(Icons.notifications_none, size: 30),
                ],
              ),

              const SizedBox(height: 35),

              const Text(
                "Log Activity",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "What did you practice today?",
                style: TextStyle(fontSize: 20, color: Colors.black54),
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
                      children: [Text("5m"), Text("3h")],
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
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2035),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                            dateController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
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

                    DropdownButtonFormField<String>(
                      value: selectedIntensity,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Ringan",
                          child: Text("Ringan"),
                        ),
                        DropdownMenuItem(
                          value: "Sedang",
                          child: Text("Sedang"),
                        ),
                        DropdownMenuItem(
                          value: "Tinggi",
                          child: Text("Tinggi"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedIntensity = value!;
                        });
                      },
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
                    side: const BorderSide(color: Color(0xff35694A), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, color: Color(0xff35694A)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //================ BUTTON SAVE =================
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (notesController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Silakan isi Mindful Notes"),
                        ),
                      );
                      return;
                    }

                    final activity = ActivityModel(
                      activity: activityList[selectedActivity],
                      duration: duration.round(),
                      date: selectedDate,
                      intensity: selectedIntensity,
                      notes: notesController.text.trim(),
                      createdAt: Timestamp.now(),
                    );

                    final error = await ActivityService().addActivity(activity);

                    if (!mounted) return;

                    if (error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Activity berhasil disimpan"),
                        ),
                      );

                      setState(() {
                        selectedActivity = 0;
                        duration = 45;
                        selectedDate = DateTime.now();
                        dateController.text =
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        selectedIntensity = "Sedang";
                        notesController.clear();
                      });
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5A845F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Save Activity",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              // Memberikan jarak bawah agar tidak tertutup navbar
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardScreen()),
              );
              break;

            case 1:
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
                MaterialPageRoute(builder: (_) => const StatisticsScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const StatisticsScreen(),
                ), // sebelumnya tidak ada case ini
              );
              break;
          }
        },
      ),
    );
  }
}
