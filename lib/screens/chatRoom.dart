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
                    Message: UserMap['message'],
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
        .catchError((er) {});
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
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 23.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.video),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(child: ChatMessageList()),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: messageController,
                  style: const TextStyle(fontSize: 23.0),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      hintText: "Message",
                      hintStyle: const TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 0.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey),
                ),
              ),
              const SizedBox(
                width: 10.0,
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
  final String Message;
  final bool isSentByMe;
  const MessageTile(
      {super.key, required this.Message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSentByMe ? 15 : 24, right: isSentByMe ? 24 : 15),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.4),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.deepPurple[400] : Colors.blueGrey,
          borderRadius: isSentByMe
              ? const BorderRadius.only(
                  topRight: Radius.circular(23),
                  topLeft: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : const BorderRadius.only(
                  topRight: Radius.circular(23),
                  topLeft: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
        ),
        child: Text(
          Message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
