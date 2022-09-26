import 'package:firebase_app/screens/login.dart';
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
  List<List<String>> search_data = [
    ['Harsh', 'hey im using this'],
    ['Harsh', 'hey im using this'],
    ['Harsh', 'hey im using this'],
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
          itemBuilder: (context, index) {
            return Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          search_data[index][0],
                          style: TextStyle(fontSize: 23.0, color: Colors.black),
                        ),
                        Text(
                          search_data[index][1],
                          style: TextStyle(
                              fontSize: 19.0, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        "Chat",
                        style: TextStyle(
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
