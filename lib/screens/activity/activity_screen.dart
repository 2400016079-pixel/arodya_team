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

  @override
  void dispose() {
    dateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;
    final hPad = size.width * 0.055;

    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),
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
                          color: const Color(0xff4F7F5D),
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
                "Log Activity",
                style: TextStyle(
                  fontSize: isSmall ? 28 : 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "What did you practice today?",
                style: TextStyle(
                  fontSize: isSmall ? 14 : 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 26),

              //================ ACTIVITY GRID =================
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ActivityItem(
                    icon: Icons.directions_walk,
                    title: "Walking",
                    selected: selectedActivity == 0,
                    onTap: () => setState(() => selectedActivity = 0),
                  ),
                  ActivityItem(
                    icon: Icons.directions_run,
                    title: "Running",
                    selected: selectedActivity == 1,
                    onTap: () => setState(() => selectedActivity = 1),
                  ),
                  ActivityItem(
                    icon: Icons.pedal_bike,
                    title: "Cycling",
                    selected: selectedActivity == 2,
                    onTap: () => setState(() => selectedActivity = 2),
                  ),
                  ActivityItem(
                    icon: Icons.self_improvement,
                    title: "Yoga",
                    selected: selectedActivity == 3,
                    onTap: () => setState(() => selectedActivity = 3),
                  ),
                  ActivityItem(
                    icon: Icons.pool,
                    title: "Swimming",
                    selected: selectedActivity == 4,
                    onTap: () => setState(() => selectedActivity = 4),
                  ),
                  ActivityItem(
                    icon: Icons.fitness_center,
                    title: "Weights",
                    selected: selectedActivity == 5,
                    onTap: () => setState(() => selectedActivity = 5),
                  ),
                  ActivityItem(
                    icon: Icons.timer,
                    title: "HIIT",
                    selected: selectedActivity == 6,
                    onTap: () => setState(() => selectedActivity = 6),
                  ),
                  ActivityItem(
                    icon: Icons.accessibility_new,
                    title: "Pilates",
                    selected: selectedActivity == 7,
                    onTap: () => setState(() => selectedActivity = 7),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              //================ FORM CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 16,
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
                        Text(
                          "Duration",
                          style: TextStyle(
                            fontSize: isSmall ? 18 : 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${duration.round()} min",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff35694A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                        Text("5m", style: TextStyle(fontSize: 13)),
                        Text("3h", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 22),

                    //================ DATE =================
                    Text(
                      "Date",
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_today, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
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
                    const SizedBox(height: 20),

                    //================ INTENSITY =================
                    Text(
                      "Intensity",
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      value: selectedIntensity,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
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

                    const SizedBox(height: 20),
                    //================ NOTES =================
                    Text(
                      "Mindful Notes",
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "How did you feel during this movement?",
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

              //================ BUTTON CANCEL =================
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff35694A), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, color: Color(0xff35694A)),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              //================ BUTTON SAVE =================
              SizedBox(
                width: double.infinity,
                height: 52,
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
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    "Save Activity",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 24),
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
              // PERBAIKAN: sebelumnya index 3 (Mood) malah nge-push ke
              // StatisticsScreen, sekarang bener ke MoodScreen.
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
    );
  }
}
