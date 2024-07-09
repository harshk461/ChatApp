import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/utils/currentUser.dart';
import 'package:chat_app/utils/spinner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatRoom extends StatefulWidget {
  final String name;
  final String ChatID;
  const ChatRoom({super.key, required this.name, required this.ChatID});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot>? ChatMessageStream;

  String? Mail = Constants.UserMail;
  String? Name = Constants.UserName;

  getConversation(String ChatID) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(ChatID)
        .collection("chats")
        .orderBy('time', descending: false)
        .snapshots();
  }

  Widget ChatMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: ChatMessageStream,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> UserMap =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return MessageTile(
                    message: UserMap['message'],
                    isSentByMe: UserMap['sendBy'] == Constants.UserName);
              },
            );
          } else {
            return Container();
          }
        } else {
          return const Spinner();
        }
      }),
    );
  }

  AddMessage(String chatRoomID, messagegMap) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(messagegMap)
        .catchError((er) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send message: $er"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  SendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text.trim(),
        'sendBy': Constants.UserName,
        'time': DateTime.now().microsecondsSinceEpoch
      };
      AddMessage(widget.ChatID, messageMap);
    }
  }

  @override
  void initState() {
    getConversation(widget.ChatID).then((value) {
      setState(() {
        ChatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.video,
              size: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.phone,
              size: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: Column(children: [
        SizedBox(
          height: 10.0,
        ),
        Expanded(child: ChatMessageList()),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: messageController,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: "Message",
                    hintStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.blue.shade900),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.blue.shade900),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              IconButton(
                splashColor: Colors.red,
                onPressed: () {
                  SendMessage();
                  messageController.text = '';
                },
                icon: const FaIcon(
                  FontAwesomeIcons.paperPlane,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const MessageTile(
      {super.key, required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSentByMe ? 8 : 16, right: isSentByMe ? 16 : 8),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.4),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSentByMe
              ? Colors.blue.shade900
              : Color.fromARGB(255, 47, 55, 58),
          borderRadius: isSentByMe
              ? const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}
