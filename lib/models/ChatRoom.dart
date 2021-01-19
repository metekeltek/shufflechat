import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  List<dynamic> users = [];
  String chatRoomId = '';

  ChatRoom();

  void setChatRoomModel(ChatRoom chatRoom) {
    if (chatRoom != null) {
      this.users = chatRoom.users;
      this.chatRoomId = chatRoom.chatRoomId;
    }
  }

  Map<String, dynamic> toJson() => {'users': users, 'chatRoomId': chatRoomId};

  ChatRoom.fromMap(Map map)
      : users = map['users'] ?? '',
        chatRoomId = map['chatRoomId'] ?? '';

  ChatRoom.fromFirestore(DocumentSnapshot snap)
      : users = snap['users'] ?? '',
        chatRoomId = snap['chatRoomId'] ?? '';

  ChatRoom.queryfromFirestore(QuerySnapshot querySnap)
      : users = querySnap.docs[0]['users'] ?? '',
        chatRoomId = querySnap.docs[0]['chatRoomId'] ?? '';
}
