import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shufflechat/models/ChatRoom.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/services/chatFunctions.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatScreen extends StatefulWidget {
  final List<String> filterArray;
  final List<String> userDataArray;

  ChatScreen(this.filterArray, this.userDataArray);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatFunctions chatFunctions = ChatFunctions();
  TextEditingController _chatMessageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String uid;
  String chatPartnerId = '';
  Stream chatMessagesStream;
  bool isTyping = false;
  final clickHereForMoreInfo = 'clickHereForMore'.tr();
  final chatPartnerWritingInfo = 'userWriting'.tr();

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 8.0),
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
    if (_chatMessageController.text.trim().isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': _chatMessageController.text.trim(),
        'sendBy': uid,
        'time': DateTime.now().microsecondsSinceEpoch
      };
      chatFunctions.sendConversationMessage(chatRoomId, messageMap);
      _chatMessageController.text = '';
    }
  }

  void checkIfIsTyping(DatabaseProvider databaseProvider) {
    if (_chatMessageController.text == '') {
      if (isTyping) {
        isTyping = false;
        databaseProvider.setIsWriting(false);
      }
    } else {
      if (!isTyping) {
        isTyping = true;
        databaseProvider.setIsWriting(true);
      }
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
    final databaseProvider = context.watch<DatabaseProvider>();
    uid = databaseProvider.uid;

    Stream<ChatRoom> chatRoomStream = databaseProvider.streamChatRooms();

    return StreamBuilder<ChatRoom>(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            chatMessagesStream =
                chatFunctions.getConversationMessages(snapshot.data.chatRoomId);

            chatPartnerId = snapshot.data.users[0] == uid
                ? snapshot.data.users[1]
                : snapshot.data.users[0];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffff9600),
                toolbarHeight: 85,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    chatRoomStream = null;
                    databaseProvider.deleteChatRoom(snapshot.data.chatRoomId);
                    Navigator.pop(context);
                  },
                ),
                title: StreamBuilder<UserData>(
                    stream: databaseProvider.streamUserData(chatPartnerId),
                    builder: (context, chatPartnerSnapshot) {
                      if (chatPartnerSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (chatPartnerSnapshot.hasError) {
                          return Container();
                        }
                        if (chatPartnerSnapshot.data.profilePictureURL !=
                                null &&
                            chatPartnerSnapshot.data.name != null) {
                          var image = NetworkImage(
                              chatPartnerSnapshot.data.profilePictureURL);
                          return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => ImageInterestsDialog(image,
                                      chatPartnerSnapshot.data.interests));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: image,
                                  radius: 20.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(chatPartnerSnapshot.data.name,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        chatPartnerSnapshot.data.isWriting
                                            ? chatPartnerWritingInfo
                                            : clickHereForMoreInfo,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else if (chatPartnerSnapshot.data.name != null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(chatPartnerSnapshot.data.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  chatPartnerSnapshot.data.isWriting
                                      ? chatPartnerWritingInfo
                                      : clickHereForMoreInfo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ],
                          );
                        }
                        return Container(
                          child: Text(
                              chatPartnerSnapshot.data.isWriting ??
                                  chatPartnerWritingInfo,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        );
                      } else {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xffff9600)),
                          strokeWidth: 4,
                        );
                      }
                    }),
                actions: [
                  Container(
                    padding: const EdgeInsets.only(right: 15, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.only(top: 13),
                          icon: const Icon(
                            Icons.shuffle_rounded,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            databaseProvider
                                .deleteChatRoom(snapshot.data.chatRoomId);
                          },
                        ),
                        Text(
                          'next'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
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
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 18, right: 12, bottom: 30),
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
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 250),
                                  child: Container(
                                    child: TextFormField(
                                      onChanged: (_) =>
                                          checkIfIsTyping(databaseProvider),
                                      maxLines: null,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: _chatMessageController,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'sendMessage'.tr(),
                                        focusColor: Colors.black,
                                        fillColor: Colors.black,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              const BorderSide(width: 0.4),
                                          borderRadius:
                                              BorderRadius.circular(27.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              const BorderSide(width: 0.4),
                                          borderRadius:
                                              BorderRadius.circular(27.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                sendMessage(snapshot.data.chatRoomId);
                                checkIfIsTyping(databaseProvider);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.all(5),
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
              if (chatPartnerId != '') {
                databaseProvider.createShuffleUser(
                    chatPartnerId, widget.filterArray, widget.userDataArray);
              } else {
                databaseProvider.createShuffleUser(
                    '', widget.filterArray, widget.userDataArray);
              }
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffff9600),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    context.read<DatabaseProvider>().deleteShuffleUser();
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(const Color(0xffff9600)),
                  strokeWidth: 4,
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
      margin: isSendByMe
          ? const EdgeInsets.only(left: 50)
          : const EdgeInsets.only(right: 20),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Colors.grey[300], Colors.grey[300]]
                    : [Colors.amber[400], const Color(0xffff9600)]),
            borderRadius: BorderRadius.circular(22.0)),
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}

class ImageInterestsDialog extends StatelessWidget {
  final profileImage;
  final interests;

  ImageInterestsDialog(this.profileImage, this.interests);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffff9600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(500.0),
      ),
      child: Container(
        height: 400,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(400.0),
                  image: DecorationImage(
                    image: profileImage,
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text('interests'.tr(),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              child: Text(listToString(interests),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }
}

String listToString(List<dynamic> interests) {
  var interestsString = '';
  for (var intrest in interests) {
    interestsString += intrest.toString().tr() + ', ';
  }

  interestsString = interestsString.substring(0, interestsString.length - 2);
  return interestsString;
}
