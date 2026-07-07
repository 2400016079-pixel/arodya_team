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
}