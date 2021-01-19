import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shufflechat/models/ChatRoom.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/services/chatFunctions.dart';
import 'package:shufflechat/services/dbProvider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatFunctions chatFunctions = ChatFunctions();
  TextEditingController _chatMessageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  dynamic chatPartner = UserData();
  Stream chatMessagesStream;
  String uid;

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(top: 8.0),
                  reverse: true,
                  controller: _scrollController,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data.documents[index].data()['message'],
                        snapshot.data.documents[index].data()['sendBy'] == uid);
                  })
              : Container();
        });
  }

  sendMessage(String chatRoomId) {
    if (_chatMessageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': _chatMessageController.text,
        'sendBy': uid,
        'time': DateTime.now().microsecondsSinceEpoch
      };
      chatFunctions.sendConversationMessage(chatRoomId, messageMap);
      _chatMessageController.text = '';
    }
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 0),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    uid = firebaseUser.uid;
    context.watch<DatabaseProvider>().getShuffleUser(firebaseUser.uid);
    Stream<ChatRoom> chatRoomStream =
        context.watch<DatabaseProvider>().streamChatRooms(firebaseUser.uid);

    return StreamBuilder<ChatRoom>(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Provider.of<DatabaseProvider>(context)
                .deleteShuffleUser(firebaseUser.uid);
            chatMessagesStream =
                chatFunctions.getConversationMessages(snapshot.data.chatRoomId);
            var chatPartnerId = snapshot.data.users
                .where((element) => element != uid)
                .toList()
                .first
                .toString();
            chatPartner = Provider.of<DatabaseProvider>(context)
                .getUserData(chatPartnerId);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    chatRoomStream = null;
                    context
                        .read<DatabaseProvider>()
                        .deleteChat(snapshot.data.chatRoomId);
                    context
                        .read<DatabaseProvider>()
                        .deleteChatRoom(snapshot.data.chatRoomId);
                    Navigator.pop(context);
                  },
                ),
                title: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    //TODO:
                    backgroundImage: new NetworkImage(''),
                    radius: 30.0,
                  ),
                  tooltip: 'Show User',
                  onPressed: () {},
                ),
                backgroundColor: Colors.amberAccent[700],
                actions: [
                  IconButton(
                    padding: EdgeInsets.only(right: 40),
                    icon: const Icon(Icons.shuffle),
                    tooltip: 'Next Shuffle',
                    onPressed: () {
                      context
                          .read<DatabaseProvider>()
                          .deleteChat(snapshot.data.chatRoomId);
                      context
                          .read<DatabaseProvider>()
                          .deleteChatRoom(snapshot.data.chatRoomId);
                    },
                  ),
                ],
              ),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Stack(
                            children: [chatMessageList()],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 12, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 9,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _chatMessageController,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Send a message...',
                                    focusColor: Colors.black,
                                    fillColor: Colors.black,
                                    hintStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 0.4),
                                      borderRadius: BorderRadius.circular(27.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 0.4),
                                      borderRadius: BorderRadius.circular(27.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                sendMessage(snapshot.data.chatRoomId);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.keyboard_arrow_up_sharp,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            if (chatRoomStream != null) {
              Provider.of<DatabaseProvider>(context)
                  .getShuffleUser(firebaseUser.uid);
              Provider.of<DatabaseProvider>(context)
                  .createShuffleUser(firebaseUser.uid, '');
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amberAccent[700],
                actions: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    tooltip: 'Go back',
                    onPressed: () {
                      context
                          .read<DatabaseProvider>()
                          .deleteShuffleUser(firebaseUser.uid);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              body: Center(
                child: Container(
                  child: Text('looking for chat partners'),
                ),
              ),
            );
          }
        });
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          isSendByMe ? EdgeInsets.only(left: 50) : EdgeInsets.only(right: 20),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 13),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Colors.grey[300], Colors.grey[300]]
                    : [Colors.amber[400], Colors.amberAccent[700]]),
            borderRadius: BorderRadius.circular(22.0)),
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
