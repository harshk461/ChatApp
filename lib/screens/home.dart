import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/searchpage.dart';
import 'package:firebase_app/utils/chat_card.dart';
import 'package:firebase_app/models/constants.dart';
import 'package:firebase_app/utils/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot>? ChatRoomStream;

  Widget ChatRoomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: ChatRoomStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> roomMap =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return ChatCard(
                  name: roomMap["chatroomID"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(constants.Myname.toString(), ""),
                  ID: roomMap["chatroomID"],
                  about: '',
                );
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
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> userdata = [
      ['Harsh1', 'Hey im using this'],
      ['Harsh2', 'Hey im using this'],
      ['Harsh3', 'Hey im using this'],
    ];
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
            child: const FaIcon(FontAwesomeIcons.add),
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
                      icon: const FaIcon(FontAwesomeIcons.signOut),
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
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: userdata.length,
                  itemBuilder: (context, index) => ChatCard(
                    name: userdata[index][0],
                    about: userdata[index][1],
                    ID: (index + 1).toString(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
