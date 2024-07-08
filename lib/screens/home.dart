import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screens/chatRoom.dart';
import 'package:chat_app/screens/searchpage.dart';
import 'package:chat_app/utils/currentUser.dart';
import 'package:chat_app/utils/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot>? chatsnapshots;

  setCurrentUser() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) => {
              Constants.UserMail = value.docs[0]['email'],
              Constants.UserName = value.docs[0]['name']
            });
  }

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: chatsnapshots,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> roomMap =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return ChatRoomTile(
                    username: roomMap["chatRoomID"]
                        .toString()
                        .replaceAll("+", " ")
                        .replaceAll(Constants.UserName!, "")
                        .trim(),
                    ChatRoomID: roomMap["chatRoomID"]);
              },
            );
          } else {
            return Container();
          }
        } else {
          return const Spinner();
        }
      },
    );
  }

  @override
  void initState() {
    setCurrentUser();
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    String username = '';
    await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      username = value.docs[0]['name'];
    });
    return getChatRoom(username).then((value) {
      setState(() {
        chatsnapshots = value;
      });
    });
  }

  getChatRoom(String? username) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where("user", arrayContains: username)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: SizedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            child: const FaIcon(FontAwesomeIcons.plus),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon:
                          const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.amber,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Chats",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(child: ChatRoomList()),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String ChatRoomID;
  const ChatRoomTile(
      {super.key, required this.username, required this.ChatRoomID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatRoom(name: username, ChatID: ChatRoomID)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey[600],
              ),
              child: Center(
                child: Text(
                  username.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Center(
              child: Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
