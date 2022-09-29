import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/constants.dart';
import 'package:firebase_app/screens/login.dart';
import 'package:firebase_app/utils/search_card.dart';
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          title: TextField(
            controller: searchcontroller,
            decoration: InputDecoration(
              labelText: "Search...",
            ),
            style: TextStyle(
              fontSize: 23.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),
          ],
        ),
        body: Text(""),
        floatingActionButton: SizedBox(
          height: 60.0,
          width: 60.0,
          child: FloatingActionButton(
            splashColor: Colors.amberAccent,
            onPressed: () {
              print(FirebaseAuth.instance.currentUser);
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              }
            },
            child: FaIcon(
              FontAwesomeIcons.home,
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
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
