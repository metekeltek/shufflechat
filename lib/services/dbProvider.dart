import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shufflechat/models/ChatRoom.dart';
import 'package:shufflechat/models/ShuffleUser.dart';
import 'package:shufflechat/models/UserData.dart';
import 'dart:async';

class DatabaseProvider {
  final FirebaseFirestore _db;
  final FirebaseStorage _firebaseStorage;
  final String uid;

  DatabaseProvider(this._db, this._firebaseStorage, this.uid);

  //*UserData Methods

  Stream<UserData> get userDataStream => this.streamUserData(uid);

  Stream<UserData> streamUserData(String uid) {
    return _db
        .collection('userData')
        .doc(uid)
        .snapshots()
        .map((doc) => UserData.fromFirestore(doc));
  }

  Future<UserData> getUserData() async {
    UserData userData;
    try {
      var snap = await _db.collection('userData').doc(uid).get();
      userData = UserData.fromMap(snap.data());
      return userData;
    } catch (e) {
      return UserData();
    }
  }

  Future<void> deleteUserData() async {
    await _db.collection('userData').doc(uid).delete();
  }

  Future<void> setUser(UserData userData) {
    return _db.collection('userData').doc(uid).set(userData.toJson());
  }

  Future<void> setShuffleCoins(int shuffleCoins) {
    return _db
        .collection('userData')
        .doc(uid)
        .update({'shuffleCoins': shuffleCoins});
  }

  Future<void> setPremiumTill(Timestamp premiumTill) {
    return _db
        .collection('userData')
        .doc(uid)
        .update({'premiumTill': premiumTill});
  }

  Future<void> setIsWriting(bool isWriting) {
    return _db.collection('userData').doc(uid).update({'isWriting': isWriting});
  }

  Future<void> setInterests(List<dynamic> interests) {
    return _db.collection('userData').doc(uid).update({'interests': interests});
  }

  //*FirebaseStorage Methods

  Future<void> uploadFile(File file) async {
    try {
      await _firebaseStorage.ref('profilePictures/$uid.png').putFile(file);
    } catch (e) {}
  }

  Future<String> getFile() async {
    try {
      return await _firebaseStorage
          .ref('profilePictures/$uid.png')
          .getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteFile() async {
    try {
      return await _firebaseStorage.ref('profilePictures/$uid.png').delete();
    } catch (e) {
      return '';
    }
  }

  //*ShuffleUser Methods

  Future<void> createShuffleUser(
      String lastShuffle, List<String> filter, List<String> userData) {
    ShuffleUser shuffleUser = ShuffleUser();
    shuffleUser.shuffleUserId = uid;
    shuffleUser.lastShuffle = lastShuffle;
    shuffleUser.filter = filter;
    shuffleUser.userData = userData;
    return _db.collection('shuffleUser').doc(uid).set(shuffleUser.toJson());
  }

  void deleteShuffleUser() async {
    try {
      await _db.collection('shuffleUser').doc(uid).delete();
    } catch (e) {}
  }

  //*ChatRoom Methods

  Stream<ChatRoom> streamChatRooms() {
    var chatRoom = _db
        .collection('chatRoom')
        .where('users', arrayContains: uid)
        .snapshots()
        .map((event) => ChatRoom.queryfromFirestore(event));

    return chatRoom;
  }

  deleteChatRoom(String docId) {
    _db.collection('chatRoom').doc(docId).delete();
  }
}
