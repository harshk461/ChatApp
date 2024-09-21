import 'package:chat_app/screens/login.dart';
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
    try {
      final user = FirebaseAuth.instance.currentUser;
      // print(user);
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: user.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs[0].data();

        if (userData.containsKey('email') && userData.containsKey('name')) {
          Constants.UserMail = userData['email'];
          Constants.UserName = userData['name'];
          print("User data successfully loaded.");
        } else {
          print("Email or name field is missing in the user document.");
        }
      } else {
        print("No matching user found in the Firestore.");
      }
    } catch (e) {
      print("Error retrieving user data: $e");
    }
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

                // Split chatRoomID by '+'
                List<String> users =
                    roomMap["chatRoomID"].toString().split('+');

                // Remove the current user's username
                users.remove(Constants.UserName!);

                // The remaining part should be the other user's username
                String otherUsername = users.join(' ');

                return ChatRoomTile(
                  username: otherUsername,
                  ChatRoomID: roomMap["chatRoomID"],
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
    setCurrentUser();
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    if (FirebaseAuth.instance.currentUser != null) {
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
    } else {
      // Handle the case where no user is logged in (e.g., navigate to login)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  getChatRoom(String? username) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where("user", arrayContains: username)
        .snapshots();
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: SizedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blue.shade900,
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
                        fontSize: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        signout();
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue.shade900,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(fontSize: 18.0),
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
          border: Border.all(width: 2.0, color: Colors.blue.shade900),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Container(
              width: 35.0,
              height: 35.0,
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
                    fontSize: 18.0,
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
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
