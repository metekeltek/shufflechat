import 'package:cloud_firestore/cloud_firestore.dart';

class ShuffleUser {
  String shuffleUserId = '';
  String lastShuffle = '';
  List<dynamic> filter = ['', '', ''];
  List<dynamic> userData = ['', '', ''];

  ShuffleUser();

  void setShuffleUserModel(ShuffleUser shuffleUser) {
    if (shuffleUser != null) {
      this.shuffleUserId = shuffleUser.shuffleUserId;
      this.lastShuffle = shuffleUser.lastShuffle;
      this.filter = shuffleUser.filter;
      this.userData = shuffleUser.userData;
    }
  }

  Map<String, dynamic> toJson() => {
        'shuffleUserId': shuffleUserId,
        'lastShuffle': lastShuffle,
        'filter': filter,
        'userData': userData,
      };

  ShuffleUser.fromMap(Map map)
      : shuffleUserId = map['shuffleUserId'] ?? null,
        lastShuffle = map['lastShuffle'] ?? null,
        filter = map['filter'] ?? [],
        userData = map['userData'] ?? [];

  ShuffleUser.fromFirestore(DocumentSnapshot snap)
      : shuffleUserId = snap['shuffleUserId'] ?? null,
        lastShuffle = snap['lastShuffle'] ?? null,
        filter = snap['filter'] ?? [],
        userData = snap['userData'] ?? [];
  ShuffleUser.queryfromFirestore(QuerySnapshot querySnap)
      : shuffleUserId = querySnap.docs[0]['shuffleUserId'] ?? null,
        lastShuffle = querySnap.docs[0]['lastShuffle'] ?? null,
        filter = querySnap.docs[0]['filter'] ?? [],
        userData = querySnap.docs[0]['userData'] ?? [];
}
