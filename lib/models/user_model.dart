class UserModel {
  final String uid;
  final String name;
  final String email;
  final String gender;
  final String birthDate;
  final String weight;
  final String height;
  final String photoUrl;

  // Target Harian
  final int dailyWaterTarget;
  final int dailyStepTarget;
  final bool autoRecommendation;

  // Notifikasi
  final bool hydrationReminder;
  final int reminderInterval;
  final bool activityReminder;
  final String quietStart;
  final String quietEnd;

  // Statistik
  final int dayStreak;
  final double avgDaily;
  final int todaySteps;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.photoUrl,

    required this.dailyWaterTarget,
    required this.dailyStepTarget,
    required this.autoRecommendation,

    required this.hydrationReminder,
    required this.reminderInterval,
    required this.activityReminder,
    required this.quietStart,
    required this.quietEnd,

    required this.dayStreak,
    required this.avgDaily,
    required this.todaySteps,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "gender": gender,
      "birthDate": birthDate,
      "weight": weight,
      "height": height,
      "photoUrl": photoUrl,

      "dailyWaterTarget": dailyWaterTarget,
      "dailyStepTarget": dailyStepTarget,
      "autoRecommendation": autoRecommendation,

      "hydrationReminder": hydrationReminder,
      "reminderInterval": reminderInterval,
      "activityReminder": activityReminder,
      "quietStart": quietStart,
      "quietEnd": quietEnd,

      "dayStreak": dayStreak,
      "avgDaily": avgDaily,
      "todaySteps": todaySteps,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      gender: map["gender"] ?? "",
      birthDate: map["birthDate"] ?? "",
      weight: map["weight"] ?? "",
      height: map["height"] ?? "",
      photoUrl: map["photoUrl"] ?? "",

      dailyWaterTarget: map["dailyWaterTarget"] ?? 2000,
      dailyStepTarget: map["dailyStepTarget"] ?? 10000,
      autoRecommendation: map["autoRecommendation"] ?? true,

      hydrationReminder: map["hydrationReminder"] ?? true,
      reminderInterval: map["reminderInterval"] ?? 1,
      activityReminder: map["activityReminder"] ?? false,
      quietStart: map["quietStart"] ?? "22:00",
      quietEnd: map["quietEnd"] ?? "06:00",

      dayStreak: map["dayStreak"] ?? 0,
      avgDaily: (map["avgDaily"] ?? 0).toDouble(),
      todaySteps: map["todaySteps"] ?? 0,
    );
  }
}