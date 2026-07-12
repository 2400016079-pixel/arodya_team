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