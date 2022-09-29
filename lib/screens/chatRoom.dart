import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatRoom extends StatefulWidget {
  final String name;
  final String about;
  const ChatRoom({super.key, required this.name, required this.about});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    String Name = widget.name;
    String About = widget.about;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.amber,
        title: Text(
          widget.name,
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
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Text("hello");
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 5,
                style: TextStyle(fontSize: 23.0),
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
            SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: 45.0,
              width: 45.0,
              child: FloatingActionButton(
                splashColor: Colors.red,
                onPressed: () {
                  print(Name);
                  print(About);
                },
                child: FaIcon(
                  FontAwesomeIcons.paperPlane,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
