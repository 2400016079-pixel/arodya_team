import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/activity_model.dart';

class ActivityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Menyimpan activity
  Future<String?> addActivity(ActivityModel activity) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return "User belum login";
      }

      await _firestore
          .collection("users")
          .doc(user.uid)
          .collection("activities")
          .add(activity.toMap());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Mengambil semua activity
  Stream<List<ActivityModel>> getActivities() {
    final user = _auth.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection("users")
        .doc(user.uid)
        .collection("activities")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ActivityModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  /// Menghapus activity
  Future<void> deleteActivity(String id) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("activities")
        .doc(id)
        .delete();
  }

  /// Update activity
  Future<void> updateActivity(ActivityModel activity) async {
    final user = _auth.currentUser;

    if (user == null || activity.id == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("activities")
        .doc(activity.id)
        .update(activity.toMap());
  }

  Future<int> getTodaySteps() async {
  final now = DateTime.now();

  final start = DateTime(now.year, now.month, now.day);
  final end = start.add(const Duration(days: 1));

  final snapshot = await _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("activities")
      .where(
        "date",
        isGreaterThanOrEqualTo: Timestamp.fromDate(start),
      )
      .where(
        "date",
        isLessThan: Timestamp.fromDate(end),
      )
      .get();

  int total = 0;

  for (final doc in snapshot.docs) {
    total += (doc.data()["steps"] ?? 0) as int;
  }

  return total;
}

Future<double> getAverageWater() async {
  final uid = _auth.currentUser!.uid;

  final snapshot = await _firestore
      .collection("water_logs")
      .where("uid", isEqualTo: uid)
      .get();

  if (snapshot.docs.isEmpty) return 0;

  int total = 0;

  for (final doc in snapshot.docs) {
    total += (doc.data()["amount"] ?? 0) as int;
  }

  return total / snapshot.docs.length / 1000;
}

Future<int> getDayStreak() async {
  final snapshot = await _firestore
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("activities")
      .orderBy("date", descending: true)
      .get();

  if (snapshot.docs.isEmpty) return 0;

  final days = snapshot.docs
      .map((e) => (e["date"] as Timestamp).toDate())
      .map((e) => DateTime(e.year, e.month, e.day))
      .toSet()
      .toList();

  days.sort((a, b) => b.compareTo(a));

  int streak = 0;

  DateTime current = DateTime.now();
  current = DateTime(current.year, current.month, current.day);

  for (final day in days) {
    if (day == current) {
      streak++;
      current = current.subtract(const Duration(days: 1));
    } else if (day == current.subtract(const Duration(days: 1))) {
      streak++;
      current = day.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }

  return streak;
}

}