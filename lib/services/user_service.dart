import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await firestore
        .collection("users")
        .doc(user.uid)
        .set(user.toMap());
  }

  Future<bool> userExists(String uid) async {
  final doc = await firestore
      .collection("users")
      .doc(uid)
      .get();

  return doc.exists;
}

  Future<void> updateUser(UserModel user) async {
    await firestore
        .collection("users")
        .doc(user.uid)
        .update(user.toMap());
  }

  Future<void> updateEmail(
  String uid,
  String email,
) async {
  await firestore
      .collection("users")
      .doc(uid)
      .update({
    "email": email,
  });
}

Future<void> updateTarget({
  required String uid,
  required int waterTarget,
  required int stepTarget,
  required bool autoRecommendation,
}) async {

  print("===== UPDATE TARGET =====");
  print("UID: $uid");
  print("Water: $waterTarget");
  print("Step: $stepTarget");
  print("Auto: $autoRecommendation");

  await firestore.collection("users").doc(uid).update({
    "dailyWaterTarget": waterTarget,
    "dailyStepTarget": stepTarget,
    "autoRecommendation": autoRecommendation,
  });

  final doc = await firestore
      .collection("users")
      .doc(uid)
      .get();

  print("HASIL FIRESTORE:");
  print(doc.data());
}

Future<void> updateNotification({
  required String uid,
  required bool hydrationReminder,
  required int reminderInterval,
  required bool activityReminder,
  required String quietStart,
  required String quietEnd,
}) async {
  await firestore.collection("users").doc(uid).update({
    "hydrationReminder": hydrationReminder,
    "reminderInterval": reminderInterval,
    "activityReminder": activityReminder,
    "quietStart": quietStart,
    "quietEnd": quietEnd,
  });
}

  Stream<UserModel> getUser(String uid) {
  return firestore
      .collection("users")
      .doc(uid)
      .snapshots()
      .map((doc) {
    print("Document exists: ${doc.exists}");
    print("Document data: ${doc.data()}");

    if (!doc.exists || doc.data() == null) {
      throw Exception("User tidak ditemukan");
    }

    return UserModel.fromMap(doc.data()!);
  });
}
}