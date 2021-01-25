import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  String user0 = '';
  String user1 = '';
  bool user0Typing = false;
  bool user1Typing = false;
  String chatRoomId = '';

  ChatRoom();

  void setChatRoomModel(ChatRoom chatRoom) {
    if (chatRoom != null) {
      this.user0 = chatRoom.user0;
      this.user1 = chatRoom.user1;
      this.user0Typing = chatRoom.user0Typing;
      this.user1Typing = chatRoom.user1Typing;
      this.chatRoomId = chatRoom.chatRoomId;
    }
  }

  Map<String, dynamic> toJson() => {
        'user0': user0,
        'user1': user1,
        'user0Typing': user0Typing,
        'user1Typing': user1Typing,
        'chatRoomId': chatRoomId
      };

  ChatRoom.fromMap(Map map)
      : user0 = map['user0'] ?? '',
        user1 = map['user1'] ?? '',
        user0Typing = map['user0Typing'] ?? '',
        user1Typing = map['user1Typing'] ?? '',
        chatRoomId = map['chatRoomId'] ?? '';

  ChatRoom.fromFirestore(DocumentSnapshot snap)
      : user0 = snap['user0'] ?? '',
        user1 = snap['user1'] ?? '',
        user0Typing = snap['user0Typing'] ?? '',
        user1Typing = snap['user1Typing'] ?? '',
        chatRoomId = snap['chatRoomId'] ?? '';

  ChatRoom.queryfromFirestore(QuerySnapshot querySnap)
      : user0 = querySnap.docs[0]['user0'] ?? '',
        user1 = querySnap.docs[0]['user1'] ?? '',
        user0Typing = querySnap.docs[0]['user0Typing'] ?? '',
        user1Typing = querySnap.docs[0]['user1Typing'] ?? '',
        chatRoomId = querySnap.docs[0]['chatRoomId'] ?? '';
}
