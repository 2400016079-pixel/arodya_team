import 'package:flutter/material.dart';

import '../../widgets/target_card.dart';

class DailyTargetScreen extends StatefulWidget {
  const DailyTargetScreen({super.key});

  @override
  State<DailyTargetScreen> createState() =>
      _DailyTargetScreenState();
}

class _DailyTargetScreenState
    extends State<DailyTargetScreen> {

  bool autoRecommendation = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF8FAF9),

      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Target Harian",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Column(

          children: [

            TargetCard(

              icon: Icons.water_drop,

              iconColor: Colors.blue,

              title: "Target Hidrasi",

              value: "2000",

              unit: "ml",

              sliderValue: 2,

              min: 1,

              max: 4,

              minLabel: "1L",

              maxLabel: "4L",

            ),

            const SizedBox(height:30),
                        TargetCard(

              icon: Icons.directions_walk,

              iconColor: const Color(0xff4F7F5D),

              title: "Target Langkah",

              value: "10000",

              unit: "langkah",

              sliderValue: 10,

              min: 3,

              max: 20,

              minLabel: "3k",

              maxLabel: "20k",

            ),

            const SizedBox(height: 35),

            Container(

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius: BorderRadius.circular(30),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                    offset: const Offset(0,8),
                  ),

                ],
              ),

              child: Row(

                children: [

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Rekomendasi Otomatis",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height:12),

                        const Text(
                          "Hitung target otomatis\nberdasarkan berat badan dan\naktivitas",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Switch(

                    value: autoRecommendation,

                    activeColor: Colors.white,

                    activeTrackColor:
                        const Color(0xff4F7F5D),

                    onChanged: (value){

                      setState(() {
                        autoRecommendation = value;
                      });

                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height: 60),
                        SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(

                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Target berhasil diperbarui",
                      ),
                    ),

                  );

                },

                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff35694A),

                  elevation: 5,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),

                ),

                child: const Text(

                  "Simpan Perubahan",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}