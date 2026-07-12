import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/user_service.dart';

class DailyTargetScreen extends StatefulWidget {
  const DailyTargetScreen({super.key});

  @override
  State<DailyTargetScreen> createState() =>
      _DailyTargetScreenState();
}

class _DailyTargetScreenState
    extends State<DailyTargetScreen> {

      final waterController = TextEditingController();
      final stepController = TextEditingController();

  bool autoRecommendation = true;

  @override
void initState() {
  super.initState();
  loadTarget();
}

Future<void> loadTarget() async {
  final uid = AuthService().currentUser!.uid;

  final user = await UserService()
      .getUser(uid)
      .first;

  setState(() {
   waterController.text =
    user.dailyWaterTarget.toString();

stepController.text =
    user.dailyStepTarget.toString();
    autoRecommendation = user.autoRecommendation;
  });
}

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

           Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 12,
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text(
        "Target Hidrasi",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 20),

      TextField(
        controller: waterController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: "Target Air (ml)",
          border: OutlineInputBorder(),
          suffixText: "ml",
        ),
      ),
    ],
  ),
),

            const SizedBox(height:30),
                        Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 12,
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Target Langkah",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 20),

      TextField(
        controller: stepController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: "Target Langkah",
          border: OutlineInputBorder(),
          suffixText: "langkah",
        ),
      ),
    ],
  ),
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

  onPressed: () async {
  final uid = AuthService().currentUser!.uid;

  final water =
      int.tryParse(waterController.text) ?? 2000;

  final step =
      int.tryParse(stepController.text) ?? 10000;

  await UserService().updateTarget(
    uid: uid,
    waterTarget: water,
    stepTarget: step,
    autoRecommendation: autoRecommendation,
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Target berhasil diperbarui"),
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