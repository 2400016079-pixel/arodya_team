import 'package:flutter/material.dart';

import '../../widgets/device_card.dart';

class ConnectedDevicesScreen extends StatefulWidget {
  const ConnectedDevicesScreen({super.key});

  @override
  State<ConnectedDevicesScreen> createState() =>
      _ConnectedDevicesScreenState();
}

class _ConnectedDevicesScreenState extends State<ConnectedDevicesScreen> {
  bool appleHealthConnected = true;

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Perangkat Terhubung",
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
              "SYSTEM HEALTH SYNC",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sinkronisasi otomatis langkah kaki dan kalori harian dari aplikasi kesehatan sistem Anda.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            //================ DEVICE CARD: APPLE HEALTH =================
            DeviceCard(
              title: "Apple Health",
              status: appleHealthConnected ? "✔ Terhubung" : "Belum Terhubung",
              connected: appleHealthConnected,
              imagePath: "assets/images/apple_health.png",
              onChanged: (value) {
                setState(() {
                  appleHealthConnected = value;
                });

                // Menampilkan informasi pop-up snackbar saat status switch berubah
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value
                          ? "Apple Health berhasil dihubungkan."
                          : "Apple Health diputuskan.",
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            //================ DEVICE CARD: GOOGLE FIT =================
            DeviceCard(
              title: "Google Fit",
              status: "Belum Terhubung",
              connected: false,
              imagePath: "assets/images/google_fit.png",
              onChanged: (value) {
                // Di sini kamu juga bisa mengontrol logika switch untuk Google Fit jika diperlukan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Menghubungkan ke Google Fit..."),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),

            //================ SYNC STATUS =================
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sync,
                    color: Colors.grey.shade600,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Sinkronisasi terakhir: Hari ini, 08:15 AM",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}