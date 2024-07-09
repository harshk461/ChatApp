import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final cnfpasswardcontroller = TextEditingController();

  String validatePassword(String value) {
    if (!(value.toString().length > 5) && value.isNotEmpty) {
      return "Length should be greater than 5";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.black),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Sign up to get started",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextField(
                          controller: emailcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.lightGreenAccent,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: usernamecontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.lightGreenAccent,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: passwordcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.lightGreenAccent,
                                width: 3.0,
                              ),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: cnfpasswardcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.lightGreenAccent,
                                width: 3.0,
                              ),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          width: 150.0,
                          height: 40.0,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Register();
                            },
                            icon: const Icon(
                              Icons.lock_open,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            label: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have account,",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            InkWell(
                              child: const Text(
                                " Login",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Register() async {
    try {
      if (passwordcontroller.text.trim() != cnfpasswardcontroller.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter Correct Password"),
          backgroundColor: Colors.amber,
        ));
      } else {
        // Check if the username already exists in Firestore
        var userCollection = FirebaseFirestore.instance.collection('users');
        var querySnapshot = await userCollection
            .where('name', isEqualTo: usernamecontroller.text.trim())
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Username Already Exists"),
            backgroundColor: Colors.amber,
          ));
        } else {
          // Create user with FirebaseAuth
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim(),
          );

          // Add user details to Firestore
          await userCollection.add({
            'name': usernamecontroller.text.trim(),
            'email': emailcontroller.text.trim(),
          });

          // Navigate to login screen
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        }
      }
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'email-already-in-use') {
        setState(() {
          emailcontroller.text = '';
          passwordcontroller.text = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User Already Exists"),
          backgroundColor: Colors.amber,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ex.code.toString()),
          backgroundColor: Colors.amber,
        ));
      }
    }
  }
}
