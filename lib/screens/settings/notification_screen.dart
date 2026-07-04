import 'package:flutter/material.dart';

import '../../widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {

  bool hydrationReminder = true;

  int selectedInterval = 1;

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
          "Notifikasi",
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

            NotificationCard(

              icon: Icons.water_drop,

              iconColor: const Color(0xff2E6EA8),

              iconBackground: const Color(0xffDCEBFF),

              title: "Pengingat Hidrasi",

              subtitle: "Jangan sampai dehidrasi",

              child: Column(

                children: [

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Aktif",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      Switch(

                        value: hydrationReminder,

                        activeTrackColor:
                            const Color(0xff4F7F5D),

                        activeColor: Colors.white,

                        onChanged: (value){

                          setState(() {
                            hydrationReminder = value;
                          });

                        },
                      ),

                    ],
                  ),

                  const Divider(height:40),

                  const Align(

                    alignment: Alignment.centerLeft,

                    child: Text(
                      "Interval Waktu",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height:20),

                  Row(

                    children: [

                      _intervalButton("1 Jam",1),

                      const SizedBox(width:12),

                      _intervalButton("2 Jam",2),

                      const SizedBox(width:12),

                      _intervalButton("3 Jam",3),

                    ],
                  ),

                ],
              ),
            ),

            const SizedBox(height:30),
                        NotificationCard(

              icon: Icons.nightlight_round,

              iconColor: const Color(0xff2E6EA8),

              iconBackground: const Color(0xffDCEBFF),

              title: "Waktu Tenang",

              subtitle: "Matikan notifikasi saat istirahat",

              child: Column(

                children: [

                  Row(

                    children: [

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Mulai",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height:10),

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal:18,
                                vertical:16,
                              ),

                              decoration: BoxDecoration(

                                color:
                                    const Color(0xffECEDE8),

                                borderRadius:
                                    BorderRadius.circular(16),

                              ),

                              child: const Row(

                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [

                                  Text(
                                    "10:00 PM",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),

                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width:20),

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Selesai",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height:10),

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal:18,
                                vertical:16,
                              ),

                              decoration: BoxDecoration(

                                color:
                                    const Color(0xffECEDE8),

                                borderRadius:
                                    BorderRadius.circular(16),

                              ),

                              child: const Row(

                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [

                                  Text(
                                    "06:00 AM",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),

                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),

            const SizedBox(height:30),
                        NotificationCard(

              icon: Icons.directions_walk,

              iconColor: const Color(0xff2E6EA8),

              iconBackground: const Color(0xffDCEBFF),

              title: "Pengingat Aktivitas",

              subtitle: "Ingatkan untuk bergerak",

              child: Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Aktif",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  Switch(

                    value: false,

                    activeColor: Colors.white,

                    activeTrackColor:
                        const Color(0xff4F7F5D),

                    onChanged: (value) {},

                  ),

                ],
              ),
            ),

            const SizedBox(height: 50),

            SizedBox(

              width: double.infinity,
              height: 60,

              child: ElevatedButton(

                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Pengaturan notifikasi berhasil disimpan",
                      ),
                    ),

                  );

                },

                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff35694A),

                  elevation: 4,

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

  Widget _intervalButton(
    String text,
    int value,
  ) {

    final selected = selectedInterval == value;

    return Expanded(

      child: GestureDetector(

        onTap: () {
          setState(() {
            selectedInterval = value;
          });
        },

        child: Container(

          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),

          decoration: BoxDecoration(

            color: selected
                ? const Color(0xff4F7F5D)
                : const Color(0xffECEDE8),

            borderRadius:
                BorderRadius.circular(30),
          ),

          child: Center(

            child: Text(

              text,

              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.black87,

                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}