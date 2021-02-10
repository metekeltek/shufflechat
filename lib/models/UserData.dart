import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name = '';
  Timestamp birthday;
  int gender;
  List<dynamic> interests;
  String profilePictureURL;
  int shuffleCoins = 0;
  Timestamp premiumTill;

  UserData();

  void setUserDataModel(UserData userData) {
    if (userData != null) {
      this.birthday = userData.birthday;
      this.gender = userData.gender;
      this.name = userData.name;
      this.interests = userData.interests;
      this.profilePictureURL = userData.profilePictureURL;
      this.shuffleCoins = userData.shuffleCoins;
      this.premiumTill = userData.premiumTill;
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'birthday': birthday,
        'gender': gender,
        'interests': interests,
        'profilePictureURL': profilePictureURL,
        'shuffleCoins': shuffleCoins,
        'premiumTill': premiumTill,
      };

  UserData.fromMap(Map map)
      : name = map['name'] ?? '',
        birthday = map['birthday'] ?? '',
        gender = map['gender'] ?? 2,
        interests = map['interests'] ?? [],
        profilePictureURL = map['profilePictureURL'] ?? '',
        shuffleCoins = map['shuffleCoins'] ?? 0,
        premiumTill = map['premiumTill'] ?? null;

  UserData.fromFirestore(DocumentSnapshot snap)
      : name = snap['name'] ?? '',
        birthday = snap['birthday'] ?? '',
        gender = snap['gender'] ?? 2,
        interests = snap['interests'] ?? [],
        profilePictureURL = snap['profilePictureURL'] ?? '',
        shuffleCoins = snap['shuffleCoins'] ?? 0,
        premiumTill = snap['premiumTill'] ?? null;
}
