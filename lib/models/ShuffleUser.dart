import 'package:cloud_firestore/cloud_firestore.dart';

class ShuffleUser {
  String lastShuffle = '';
  String shuffleUserId = '';

  ShuffleUser();

  void setShuffleUserModel(ShuffleUser shuffleUser) {
    if (shuffleUser != null) {
      this.lastShuffle = shuffleUser.lastShuffle;
      this.shuffleUserId = shuffleUser.shuffleUserId;
    }
  }

  Map<String, dynamic> toJson() => {
        'lastShuffle': lastShuffle,
        'shuffleUserId': shuffleUserId,
      };

  ShuffleUser.fromMap(Map map)
      : lastShuffle = map['lastShuffle'] ?? null,
        shuffleUserId = map['shuffleUserId'] ?? null;

  ShuffleUser.fromFirestore(DocumentSnapshot snap)
      : lastShuffle = snap['lastShuffle'] ?? null,
        shuffleUserId = snap['shuffleUserId'] ?? null;
  ShuffleUser.queryfromFirestore(QuerySnapshot querySnap)
      : lastShuffle = querySnap.docs[0]['lastShuffle'] ?? null,
        shuffleUserId = querySnap.docs[0]['shuffleUserId'] ?? null;
}
