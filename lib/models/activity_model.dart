import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final String? id;
  final String activity;
  final int duration;
  final int steps;
  final DateTime date;
  final String intensity;
  final String notes;
  final Timestamp createdAt;

  ActivityModel({
    this.id,
    required this.activity,
    required this.duration,
    required this.steps,
    required this.date,
    required this.intensity,
    required this.notes,
    required this.createdAt,
  });

  /// Kirim ke Firestore
  Map<String, dynamic> toMap() {
    return {
      "activity": activity,
      "duration": duration,
      "steps": steps,
      "date": Timestamp.fromDate(date),
      "intensity": intensity,
      "notes": notes,
      "createdAt": createdAt,
    };
  }

  /// Ambil dari Firestore
  factory ActivityModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return ActivityModel(
      id: documentId,
      activity: map["activity"] ?? "",
      duration: map["duration"] ?? 0,
      steps: map["steps"] ?? 0,
      date: (map["date"] as Timestamp).toDate(),
      intensity: map["intensity"] ?? "",
      notes: map["notes"] ?? "",
      createdAt: map["createdAt"] ?? Timestamp.now(),
    );
  }
}