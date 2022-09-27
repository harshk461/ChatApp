import 'package:firebase_app/screens/login.dart';
import 'package:firebase_app/utils/search_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchcontroller = TextEditingController();
  var search_data = <List<String>>[
    ['Harsh1', 'hey im using this'],
    ['Harsh2', 'hey im using this'],
    ['Harsh3', 'hey im using this'],
  ];

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
        body: ListView.builder(
          itemCount: search_data.length,
          itemBuilder: (context, index) => SearchCard(
            name: search_data[index][0],
            about: search_data[index][1],
            ID: index.toString(),
          ),
        ),
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
