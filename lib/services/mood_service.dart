import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mood_model.dart';

class MoodService {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<String?> addMood(MoodModel mood) async {
    try {
      await firestore.collection("moods").add(
            mood.toMap(),
          );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<MoodModel>> getMoods() {
    return firestore
        .collection("moods")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MoodModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> deleteMood(String id) async {
    await firestore.collection("moods").doc(id).delete();
  }
}