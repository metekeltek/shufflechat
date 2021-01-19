import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFunctions {
  sendConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chat')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Stream<QuerySnapshot> getConversationMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chat')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
