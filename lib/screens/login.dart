import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  String validatePassword(String value) {
    if (!(value.toString().length > 5) && value.isNotEmpty) {
      return "Length should be greater than 5";
    }
    return "";
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Sign In to continue",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: emailcontroller,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: validatePassword(emailcontroller.text),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: passwordcontroller,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              ElevatedButton.icon(
                onPressed: sign_in,
                icon: const Icon(Icons.lock_open),
                label: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sign_in() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
    } on FirebaseAuthException catch (ex) {
      if (ex.code.toString() == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User Not found"),
          backgroundColor: Colors.amberAccent,
        ));
      }
      if (ex.code.toString() == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Wrong Password"),
          backgroundColor: Colors.amberAccent,
        ));
      }
    }
  }
}
