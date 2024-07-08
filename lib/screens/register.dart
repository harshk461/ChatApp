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
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
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
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(),
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
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
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
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            errorText:
                                validatePassword(passwordcontroller.text),
                            errorStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: cnfpasswardcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            errorText:
                                validatePassword(cnfpasswardcontroller.text),
                            errorStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.black),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 200.0,
                          height: 50.0,
                          child: ElevatedButton.icon(
                            onPressed: Register,
                            icon: const Icon(Icons.lock_open),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 135, 117),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            label: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
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
                              style: TextStyle(fontSize: 20.0),
                            ),
                            InkWell(
                              child: const Text(
                                " Login",
                                style: TextStyle(
                                  fontSize: 20.0,
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

  Future Register() async {
    try {
      if (passwordcontroller.text.trim() != cnfpasswardcontroller.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter Correct Password"),
          backgroundColor: Colors.amber,
        ));
      } else {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim());
        FirebaseFirestore.instance.collection('users').add({
          'name': usernamecontroller.text.trim(),
          'email': emailcontroller.text.trim(),
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
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
