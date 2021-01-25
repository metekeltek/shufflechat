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

  DatabaseProvider(this._db, this._firebaseStorage);

  //*UserData Methods

  Stream<UserData> streamUserData(String uid) {
    return _db
        .collection('userData')
        .doc(uid)
        .snapshots()
        .map((doc) => UserData.fromFirestore(doc));
  }

  Future<UserData> getUserData(String uid) async {
    UserData userData;
    try {
      var snap = await _db.collection('userData').doc(uid).get();
      userData = UserData.fromMap(snap.data());
      return userData;
    } catch (e) {
      return UserData();
    }
  }

  Future<void> deleteUserData(String uid) async {
    await _db.collection('userData').doc(uid).delete();
  }

  Future<void> setUser(String uid, UserData userData) {
    return _db.collection('userData').doc(uid).set(userData.toJson());
  }

  //*FirebaseStorage Methods

  Future<void> uploadFile(String uid, File file) async {
    try {
      await _firebaseStorage.ref('profilePictures/$uid.png').putFile(file);
    } catch (e) {}
  }

  Future<String> getFile(String uid) async {
    try {
      return await _firebaseStorage
          .ref('profilePictures/$uid.png')
          .getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  //*ShuffleUser Methods

  Future<void> createShuffleUser(String uid, String lastShuffle) {
    ShuffleUser shuffleUser = ShuffleUser();
    shuffleUser.lastShuffle = lastShuffle;
    shuffleUser.shuffleUserId = uid;
    return _db.collection('shuffleUser').doc(uid).set(shuffleUser.toJson());
  }

  Future<void> deleteShuffleUser(String uid) {
    return _db.collection('shuffleUser').doc(uid).delete();
  }

  void getShuffleUser(String uid) async {
    try {
      var thisId = await _db
          .collection('shuffleUser')
          .where('shuffleUserId', isNotEqualTo: uid)
          .limit(1)
          .get();

      createChatRoom(uid, thisId.docs.first.id);
    } catch (e) {
      createShuffleUser(uid, '');
    }
  }

  Stream<ChatRoom> streamChatRooms(String uid) {
    var chatRoom = _db
        .collection('chatRoom')
        .where('users', arrayContains: uid)
        .snapshots()
        .map((event) => ChatRoom.queryfromFirestore(event));

    return chatRoom;
  }

  //*ChatRoom Methods

  String createChatRoom(String uid0, String uid1) {
    String docId = uid0 + '_' + uid1;
    ChatRoom chatRoom = ChatRoom();
    chatRoom.user0 = uid0;
    chatRoom.user1 = uid1;
    chatRoom.chatRoomId = docId;
    _db.collection('chatRoom').doc(docId).set(chatRoom.toJson());
    return chatRoom.chatRoomId;
  }

  deleteChatRoom(String docId) {
    _db.collection('chatRoom').doc(docId).delete();
  }

  deleteChat(String docId) {
    //!Consider deleting this method, if too many db requests
    _db
        .collection('chatRoom')
        .doc(docId)
        .collection('chat')
        .get()
        .then((value) => value.docs.forEach((doc) {
              doc.reference.delete();
            }));
  }
}
