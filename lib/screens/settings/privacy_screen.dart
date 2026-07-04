import 'package:flutter/material.dart';

import '../../widgets/permission_tile.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {

  bool motionPermission = true;
  bool locationPermission = false;

  bool sleepPermission = true;
  bool stepsPermission = true;

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
          "Privasi Dan Izin Data",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "IZIN SENSOR",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height:20),

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

              child: Column(

                children: [

                  PermissionTile(

                    icon: Icons.directions_walk,

                    iconColor: const Color(0xff4F7F5D),

                    iconBackground: const Color(0xffE8F2EC),

                    title: "Aktivitas Fisik / Motion",

                    subtitle:
                        "Izin melacak langkah kaki langsung via sensor HP.",

                    value: motionPermission,

                    onChanged: (value){

                      setState(() {
                        motionPermission = value;
                      });

                    },
                  ),

                  const Divider(),

                  PermissionTile(

                    icon: Icons.location_on_outlined,

                    iconColor: const Color(0xff4F7F5D),

                    iconBackground: const Color(0xffE8F2EC),

                    title: "Lokasi (GPS)",

                    subtitle:
                        "Izin akses peta untuk fitur melacak rute jalan kaki atau lari.",

                    value: locationPermission,

                    onChanged: (value){

                      setState(() {
                        locationPermission = value;
                      });

                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height:40),
                        Text(
              "KONTROL BERBAGI DATA",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                children: [

                  PermissionTile(

                    icon: Icons.nightlight_round,

                    iconColor: const Color(0xff3D73A3),

                    iconBackground: const Color(0xffE6F0FF),

                    title: "Pola Tidur",

                    subtitle:
                        "Izinkan membaca data pola tidur.",

                    value: sleepPermission,

                    onChanged: (value) {

                      setState(() {
                        sleepPermission = value;
                      });

                    },
                  ),

                  const Divider(),

                  PermissionTile(

                    icon: Icons.directions_walk,

                    iconColor: const Color(0xff4F7F5D),

                    iconBackground: const Color(0xffE8F2EC),

                    title: "Langkah Kaki",

                    subtitle:
                        "Izinkan membaca data langkah kaki.",

                    value: stepsPermission,

                    onChanged: (value) {

                      setState(() {
                        stepsPermission = value;
                      });

                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height: 40),
                        Text(
              "PRIVASI TINGKAT LANJUT",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: SizedBox(
                width: double.infinity,
                height: 70,

                child: ElevatedButton.icon(

                  onPressed: () {

                    showDialog(

                      context: context,

                      builder: (_) => AlertDialog(

                        title: const Text("Konfirmasi"),

                        content: const Text(
                          "Yakin ingin memutuskan semua perangkat dan menghapus seluruh data?"
                        ),

                        actions: [

                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text("Batal"),
                          ),

                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Semua data berhasil dihapus.",
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("Hapus"),
                          ),

                        ],
                      ),
                    );

                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor: const Color(0xffFFE7E7),

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),

                  ),

                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 30,
                  ),

                  label: const Text(
                    "Putuskan Semua Perangkat &\nHapus Data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}