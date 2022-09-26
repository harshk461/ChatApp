import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatRoom extends StatelessWidget {
  final String name;
  final String about;
  const ChatRoom({super.key, required this.name, required this.about});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        title: Text(
          name,
          style: TextStyle(
            fontSize: 23.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.video),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      ),
      body: Text(about),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Message",
                    hintStyle: TextStyle(
                      fontSize: 23.0,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 0.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.paperPlane,
              ),
            )
          ],
        ),
      ),
    );
  }
}
