import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final List<Map<String, dynamic>> history = [

    {
      "icon": Icons.self_improvement,
      "title": "Vinyasa Flow Yoga",
      "subtitle": "45 mins • Morning Routine",
      "day": "Today",
      "time": "07:30 AM",
      "color": Colors.green,
    },

    {
      "icon": Icons.water_drop,
      "title": "Hydration Goal Met",
      "subtitle": "64 oz total",
      "day": "Today",
      "time": "02:15 PM",
      "color": Colors.blue,
    },

    {
      "icon": Icons.sentiment_satisfied_alt,
      "title": "Evening Check-in",
      "subtitle": "Relaxed & centered",
      "day": "Yesterday",
      "time": "08:00 PM",
      "color": Colors.orange,
    },

    {
      "icon": Icons.fitness_center,
      "title": "Lower Body Focus",
      "subtitle": "60 mins • Strength",
      "day": "Yesterday",
      "time": "06:00 PM",
      "color": Colors.green,
    },

  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 1,

        leadingWidth: 70,

        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xffECEFF1),
            child: Icon(
              Icons.person_outline,
              color: Colors.grey.shade700,
            ),
          ),
        ),

        title: const Text(
          "ZenFit",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xff013220),
          ),
        ),

        actions: const [

          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications_none,
              size: 32,
              color: Color(0xff013220),
            ),
          )

        ],
      ),

      body: SafeArea(

        child: Column(

          children: [

            const SizedBox(height: 35),

            const Text(
              "Riwayat",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xff013220),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Review your wellness journey.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            TabBar(

              controller: _tabController,

              indicatorColor: Colors.green,

              labelColor: Colors.green,

              unselectedLabelColor: Colors.black54,

              tabs: const [

                Tab(text: "All"),
                Tab(text: "Activity"),
                Tab(text: "Water"),
                Tab(text: "Mood"),

              ],

            ),

            const SizedBox(height: 15),

            Expanded(

              child: ListView.builder(

                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                itemCount: history.length,

                itemBuilder: (context, index) {

                  final item = history[index];

                  return Container(

                    margin: const EdgeInsets.only(bottom: 20),

                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius: BorderRadius.circular(22),

                      boxShadow: [

                        BoxShadow(

                          color: Colors.grey.withOpacity(.15),

                          blurRadius: 12,

                          offset: const Offset(0,4),

                        )

                      ],

                    ),

                    child: Row(

                      children: [

                        CircleAvatar(

                          radius: 28,

                          backgroundColor:
                              item["color"].withOpacity(.12),

                          child: Icon(

                            item["icon"],

                            color: item["color"],

                            size: 30,

                          ),

                        ),

                        const SizedBox(width: 18),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(

                                item["title"],

                                style: const TextStyle(

                                  fontSize: 18,

                                  fontWeight: FontWeight.bold,

                                ),

                              ),

                              const SizedBox(height:5),

                              Text(

                                item["subtitle"],

                                style: const TextStyle(

                                  color: Colors.black54,

                                  fontSize: 16,

                                ),

                              ),

                            ],

                          ),

                        ),
                                              Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item["day"],
                              style: TextStyle(
                                color: item["color"],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item["time"],
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff0C9E6E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: "Water",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Stats",
          ),
        ],
        onTap: (index) {
          // TODO: Navigator ke halaman lain
        },
      ),
    );
  }
}  