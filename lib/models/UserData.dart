import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name = '';
  Timestamp birthday;
  int gender;
  List<dynamic> interests;
  String profilePictureURL;
  int shuffleCoins = 0;
  Timestamp premiumTill;
  int messagesSent = 0;
  int messagesReceived = 0;
  int peopleTalkedTo = 0;
  Timestamp nextClaim;
  bool isWriting = false;

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
      this.messagesSent = userData.messagesSent;
      this.messagesReceived = userData.messagesReceived;
      this.peopleTalkedTo = userData.peopleTalkedTo;
      this.nextClaim = userData.nextClaim;
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
        'messagesSent': messagesSent,
        'messagesReceived': messagesReceived,
        'peopleTalkedTo': peopleTalkedTo,
        'nextClaim': nextClaim,
      };

  UserData.fromMap(Map map)
      : name = map['name'] ?? '',
        birthday = map['birthday'] ?? '',
        gender = map['gender'] ?? 2,
        interests = map['interests'] ?? [],
        profilePictureURL = map['profilePictureURL'] ?? '',
        shuffleCoins = map['shuffleCoins'] ?? 0,
        premiumTill = map['premiumTill'] ?? null,
        messagesSent = map['messagesSent'] ?? 0,
        messagesReceived = map['messagesReceived'] ?? 0,
        peopleTalkedTo = map['peopleTalkedTo'] ?? 0,
        nextClaim = map['nextClaim'] ?? null;

  UserData.fromFirestore(DocumentSnapshot snap)
      : name = snap['name'] ?? '',
        birthday = snap['birthday'] ?? '',
        gender = snap['gender'] ?? 2,
        interests = snap['interests'] ?? [],
        profilePictureURL = snap['profilePictureURL'] ?? '',
        shuffleCoins = snap['shuffleCoins'] ?? 0,
        premiumTill = snap['premiumTill'] ?? null,
        messagesSent = snap['messagesSent'] ?? 0,
        messagesReceived = snap['messagesReceived'] ?? 0,
        peopleTalkedTo = snap['peopleTalkedTo'] ?? 0,
        nextClaim = snap['nextClaim'] ?? null;
}
