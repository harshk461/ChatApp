import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screens/chatRoom.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/utils/currentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchcontroller = TextEditingController();

  QuerySnapshot? searchSnapShot;

  PrintData() {}

  getUserByName() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where(
          'name',
          isEqualTo: searchcontroller.text.trim(),
        )
        .get()
        .then((value) => {
              setState(() {
                searchSnapShot = value;
              })
            });
  }

  Widget SearchList() {
    return searchSnapShot != null
        ? ListView.builder(
            itemCount: searchSnapShot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (FirebaseAuth.instance.currentUser!.email !=
                  searchSnapShot!.docs[index]['email']) {
                return SearchTile(
                    username: searchSnapShot!.docs[index]['name'],
                    email: searchSnapShot!.docs[index]['email']);
              }
              if (FirebaseAuth.instance.currentUser!.email ==
                  searchSnapShot!.docs[index]['email']) {
                Constants.UserMail = searchSnapShot!.docs[index]['email'];
                Constants.UserName = searchSnapShot!.docs[index]['name'];
                return const Text("No result Found");
              } else {
                return const Text("No result found");
              }
            })
        : Container();
  }

  Widget SearchTile({required String username, required String email}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              createChatRoomandConversation(username);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text(
              "Chat",
              style: TextStyle(
                fontSize: 23.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  createChatRoomandConversation(String username) async {
    if (username != Constants.UserName) {
      String ChatRoomID = getChatRoomID(username, Constants.UserName!);
      List<String> userMap = [username, Constants.UserName!];
      Map<String, dynamic> ChatRoomMap = {
        'user': userMap,
        'chatRoomID': ChatRoomID
      };

      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(ChatRoomID)
          .set(ChatRoomMap)
          .catchError((e) {});

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatRoom(name: userMap[0], ChatID: ChatRoomID)));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey[300],
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          title: TextField(
            controller: searchcontroller,
            decoration: const InputDecoration(
              labelText: "Search...",
              labelStyle: TextStyle(color: Colors.black),
            ),
            style: const TextStyle(
              fontSize: 23.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                PrintData();
                getUserByName();
              },
              icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),
          ],
        ),
        body: SearchList(),
        floatingActionButton: SizedBox(
          height: 60.0,
          width: 60.0,
          child: IconButton(
            splashColor: Colors.amberAccent,
            onPressed: () {
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              }
            },
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.blueGrey[400],
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}

getChatRoomID(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b+$a";
  } else {
    return "$a+$b";
  }
}
