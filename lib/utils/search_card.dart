import 'package:chat_app/screens/chatRoom.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  final String name;
  final String email;
  final String ChatID;

  const SearchCard(
      {super.key,
      required this.name,
      required this.email,
      required this.ChatID});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    String Name = widget.name;

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
                widget.name,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.email,
                style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatRoom(
                            name: Name,
                            ChatID: widget.ChatID,
                          )));
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
}
