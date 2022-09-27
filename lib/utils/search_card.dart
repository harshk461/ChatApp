import 'package:firebase_app/screens/chatRoom.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  final String name;
  final String about;
  final String ID;
  const SearchCard(
      {super.key, required this.name, required this.about, required this.ID});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    String Name = widget.name;
    String About = widget.about;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              name: Name,
              about: About,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10.0),
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
                  widget.name,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.about,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                print(Name);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(name: Name, about: About),
                  ),
                );
              },
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
  }
}
