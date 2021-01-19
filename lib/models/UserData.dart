import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name = '';
  Timestamp birthday;
  int gender;
  List<dynamic> interests;
  String profilePictureURL;

  UserData();

  void setUserDataModel(UserData userData) {
    if (userData != null) {
      this.birthday = userData.birthday;
      this.gender = userData.gender;
      this.name = userData.name;
      this.interests = userData.interests;
      this.profilePictureURL = userData.profilePictureURL;
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'birthday': birthday,
        'gender': gender,
        'interests': interests,
        'profilePictureURL': profilePictureURL,
      };

  UserData.fromMap(Map map)
      : name = map['name'] ?? '',
        birthday = map['birthday'] ?? '',
        gender = map['gender'] ?? null,
        interests = map['interests'] ?? null,
        profilePictureURL = map['profilePictureURL'] ?? '';

  UserData.fromFirestore(DocumentSnapshot snap)
      : name = snap['name'] ?? '',
        birthday = snap['birthday'] ?? '',
        gender = snap['gender'] ?? null,
        interests = snap['interests'] ?? null,
        profilePictureURL = snap['profilePictureURL'] ?? '';
}
