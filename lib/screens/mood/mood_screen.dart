import 'package:flutter/material.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  int selectedMood = 0;

  final TextEditingController noteController =
      TextEditingController(text: "Hari ini produktif!");

  final List<Map<String, String>> moods = [
    {
      "emoji": "😀",
      "title": "Senang",
    },
    {
      "emoji": "🙂",
      "title": "Tenang",
    },
    {
      "emoji": "😐",
      "title": "Biasa Saja",
    },
    {
      "emoji": "😢",
      "title": "Sedih",
    },
    {
      "emoji": "😫",
      "title": "Stres",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,

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
            color: Color(0xff013220),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications_none,
              color: Color(0xff013220),
              size: 32,
            ),
          )
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 25,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                "Mood Hari Ini",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff013220),
                ),
              ),

              const SizedBox(height: 28),

              ListView.builder(
                itemCount: moods.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) {

                  final mood = moods[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xffE6E6E6),
                      ),
                    ),

                    child: ListTile(

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      leading: Text(
                        mood["emoji"]!,
                        style: const TextStyle(
                          fontSize: 36,
                        ),
                      ),

                      title: Text(
                        mood["title"]!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      trailing: Radio(
                        value: index,
                        groupValue: selectedMood,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            selectedMood = value!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              const Text(
                "Catatan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: noteController,
                maxLines: 6,

                decoration: InputDecoration(
                  hintText: "Hari ini produktif!",
                  filled: true,
                  fillColor: const Color(0xffF6F6F6),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 35),
                            SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Mood ${moods[selectedMood]["title"]} berhasil disimpan 😊",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0C9E6E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
          // nanti isi Navigator
        },
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}