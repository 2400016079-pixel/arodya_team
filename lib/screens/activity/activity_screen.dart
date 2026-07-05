import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';

import '../dashboard/dashboard_screen.dart';
import '../water/water_screen.dart';
import '../statistics/statistics_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  static const Color primaryGreen = Color(0xff1B7A4B);
  static const Color accentGreen = Color(0xff39D67C);
  static const Color borderGrey = Color(0xffD9D9D9);

  String selectedActivity = "Yoga";
  DateTime selectedDate = DateTime(2026, 6, 24);

  final TextEditingController durasiController = TextEditingController(
    text: "30",
  );
  final TextEditingController catatanController = TextEditingController();

  final List<Map<String, dynamic>> activityTypes = const [
    {"label": "Yoga", "icon": Icons.self_improvement},
    {"label": "Lari", "icon": Icons.directions_run},
    {"label": "Gym", "icon": Icons.fitness_center},
    {"label": "Sepeda", "icon": Icons.directions_bike},
  ];

  final List<Map<String, dynamic>> recentActivities = const [
    {
      "icon": Icons.self_improvement,
      "iconBg": Color(0xffDDF5E8),
      "iconColor": Color(0xff2E7D4F),
      "title": "Vinyasa Flow Yoga",
      "subtitle": "Hari ini, 07:00",
      "duration": "45 Menit",
      "highlighted": true,
    },
    {
      "icon": Icons.directions_run,
      "iconBg": Color(0xffF1F1F1),
      "iconColor": Colors.black87,
      "title": "Lari Pagi (Taman)",
      "subtitle": "Kemarin, 06:30",
      "duration": "30 Menit",
      "highlighted": false,
    },
    {
      "icon": Icons.fitness_center,
      "iconBg": Color(0xffF1F1F1),
      "iconColor": Colors.black87,
      "title": "Latihan Beban Upper Body",
      "subtitle": "2 Hari Lalu, 17:00",
      "duration": "60 Menit",
      "highlighted": false,
    },
  ];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  String get formattedDate {
    final mm = selectedDate.month.toString().padLeft(2, '0');
    final dd = selectedDate.day.toString().padLeft(2, '0');
    return "$mm/$dd/${selectedDate.year}";
  }

  InputBorder _fieldBorder([Color color = borderGrey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  void dispose() {
    durasiController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ================= TOP BAR =================
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xffE9E9E9),
                    child: Icon(Icons.person, color: Colors.black54, size: 22),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "ZenFit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, size: 26),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= HEADER =================
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.arrow_back, size: 26),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "Tambah Aktivitas",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ================= FORM CARD =================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Jenis Aktivitas",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: activityTypes.map((activity) {
                              final bool isSelected =
                                  selectedActivity == activity["label"];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedActivity = activity["label"];
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? accentGreen
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: isSelected
                                          ? accentGreen
                                          : borderGrey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        activity["icon"],
                                        size: 18,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        activity["label"],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            "Durasi (menit)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: durasiController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "30",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: _fieldBorder(),
                              enabledBorder: _fieldBorder(),
                              focusedBorder: _fieldBorder(accentGreen),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            "Tanggal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: borderGrey),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            "Catatan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: catatanController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Jogging pagi di taman.",
                              contentPadding: const EdgeInsets.all(16),
                              border: _fieldBorder(),
                              enabledBorder: _fieldBorder(),
                              focusedBorder: _fieldBorder(accentGreen),
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // TODO: simpan aktivitas ke storage / backend
                              },
                              icon: const Icon(Icons.save, color: Colors.white),
                              label: const Text(
                                "Simpan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ================= AKTIVITAS TERAKHIR =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Aktivitas Terakhir",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ...recentActivities.map((activity) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: activity["iconBg"],
                              child: Icon(
                                activity["icon"],
                                color: activity["iconColor"],
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity["title"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    activity["subtitle"],
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  activity["duration"],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (activity["highlighted"] == true) ...[
                                  const SizedBox(height: 6),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: accentGreen,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
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
              // Sudah di Activity
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
          }
        },
      ),
    );
  }
}
