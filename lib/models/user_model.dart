class UserModel {
  final String uid;
  final String name;
  final String email;
  final String gender;
  final String birthDate;
  final String weight;
  final String height;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.photoUrl,
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
    );
  }
}