import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  List<String> users = ['', ''];
  List<bool> usersTyping = [false, false];
  String chatRoomId = '';

  ChatRoom();

  void setChatRoomModel(ChatRoom chatRoom) {
    if (chatRoom != null) {
      this.users = chatRoom.users;
      this.usersTyping = chatRoom.usersTyping;
      this.chatRoomId = chatRoom.chatRoomId;
    }
  }

  Map<String, dynamic> toJson() =>
      {'users': users, 'usersTyping': usersTyping, 'chatRoomId': chatRoomId};

  ChatRoom.fromMap(Map map)
      : users = map['users'] ?? '',
        usersTyping = map['usersTyping'] ?? '',
        chatRoomId = map['chatRoomId'] ?? '';

  ChatRoom.fromFirestore(DocumentSnapshot snap)
      : users = snap['users'] ?? '',
        usersTyping = snap['usersTyping'] ?? '',
        chatRoomId = snap['chatRoomId'] ?? '';

  ChatRoom.queryfromFirestore(QuerySnapshot querySnap)
      : users = querySnap.docs[0]['users'] ?? '',
        usersTyping = querySnap.docs[0]['usersTyping'] ?? '',
        chatRoomId = querySnap.docs[0]['chatRoomId'] ?? '';
}
