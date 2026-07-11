class WaterModel {
  final String id;
  final String uid;
 final int amount;
  final String drinkType;
  final DateTime date;

  WaterModel({
    required this.id,
    required this.uid,
    required this.amount,
    required this.drinkType,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "amount": amount,
      "drinkType": drinkType,
      "date": date,
    };
  }

  factory WaterModel.fromMap(Map<String, dynamic> map) {
    return WaterModel(
      id: map["id"] ?? "",
      uid: map["uid"] ?? "",
      amount: map["amount"] ?? 0,
      drinkType: map["drinkType"] ?? "Water",
      date: map["date"].toDate(),
    );
  }
}