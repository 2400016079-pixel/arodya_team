import 'package:cloud_firestore/cloud_firestore.dart';

class MoodModel {
  final String? id;
  final String mood;
  final String factor;
  final String note;
  final Timestamp createdAt;

  MoodModel({
    this.id,
    required this.mood,
    required this.factor,
    required this.note,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "mood": mood,
      "factor": factor,
      "note": note,
      "createdAt": createdAt,
    };
  }

  factory MoodModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return MoodModel(
      id: documentId,
      mood: map["mood"] ?? "",
      factor: map["factor"] ?? "",
      note: map["note"] ?? "",
      createdAt: map["createdAt"] ?? Timestamp.now(),
    );
  }
}