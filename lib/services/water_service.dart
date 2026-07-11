import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/water_model.dart';

class WaterService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference waterCollection =
      FirebaseFirestore.instance.collection("water_logs");

  // ================= TAMBAH AIR =================

  Future<void> addWater(WaterModel water) async {
    await waterCollection.doc(water.id).set(water.toMap());
  }

  // ================= RIWAYAT AIR =================

  Stream<List<WaterModel>> getWaterHistory(String uid) {
  return waterCollection
      .where("uid", isEqualTo: uid)
      .snapshots()
      .map((snapshot) {
        final list = snapshot.docs
            .map(
              (doc) => WaterModel.fromMap(
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();

        // Urutkan dari yang terbaru
        list.sort((a, b) => b.date.compareTo(a.date));

        return list;
      });
}

  // ================= TOTAL AIR HARI INI =================

  Stream<int> getTodayWater(String uid) {
    return waterCollection
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          final now = DateTime.now();

          int total = 0;

          print("Jumlah dokumen: ${snapshot.docs.length}");

          for (var doc in snapshot.docs) {
            final data = doc.data() as Map<String, dynamic>;

            final date = (data["date"] as Timestamp).toDate();

            if (date.year == now.year &&
                date.month == now.month &&
                date.day == now.day) {
              total += data["amount"] as int;
            }
          }

          print("TOTAL = $total");

          return total;
        });
  }
}