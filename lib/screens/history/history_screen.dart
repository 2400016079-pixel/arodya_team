import 'package:flutter/material.dart';

import '../../widgets/bottom_navbar.dart';
import '../../widgets/history_event_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

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

              const SizedBox(height: 40),

              //================ TITLE: TODAY =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Oct 24, 2023",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              //================ EVENTS: TODAY =================
              const HistoryEventCard(
                icon: Icons.directions_run,
                iconBg: Color(0xffE5EFE8),
                iconColor: Color(0xff35694A),
                title: "Morning Run",
                description:
                    "Crisp air, felt very energized throughout the route.",
                time: "07:30 AM",
                tags: [
                  "Cardio",
                  "5.2 km",
                  "42 min",
                ],
              ),

              const HistoryEventCard(
                icon: Icons.water_drop,
                iconBg: Color(0xffDCEBFF),
                iconColor: Color(0xff2E6EA8),
                title: "Hydration",
                description: "Logged 500ml",
                time: "10:15 AM",
                tags: [
                  "500 ml",
                ],
              ),

              const HistoryEventCard(
                icon: Icons.sentiment_satisfied_alt,
                iconBg: Color(0xffE5EFE8),
                iconColor: Color(0xff5F6B63),
                title: "Check-in",
                description: "Feeling focused and calm after lunch.",
                time: "01:00 PM",
                tags: [
                  "Productive",
                  "Balanced",
                ],
              ),

              const SizedBox(height: 30),
              
              //================ TITLE: YESTERDAY =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Yesterday",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Oct 23, 2023",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              //================ EVENTS: YESTERDAY =================
              const HistoryEventCard(
                icon: Icons.self_improvement,
                iconBg: Color(0xffE5EFE8),
                iconColor: Color(0xff35694A),
                title: "Evening Yoga",
                description:
                    "Restorative flow. Needed the stretch after a long desk day.",
                time: "08:00 PM",
                tags: [
                  "Flexibility",
                  "30 min",
                ],
              ),

              const HistoryEventCard(
                icon: Icons.water_drop,
                iconBg: Color(0xffDCEBFF),
                iconColor: Color(0xff2E6EA8),
                title: "Daily Goal Met",
                description: "Total: 2500ml ✅",
                time: "06:45 PM",
                tags: [
                  "2500 ml",
                  "Goal Achieved",
                ],
              ),

              const SizedBox(height: 100),
            ], 
          ),
        ),
      ),

      //================ BOTTOM NAVBAR =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              // Sudah berada di History
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              break;
          }
        },
      ),
    );
  }
}