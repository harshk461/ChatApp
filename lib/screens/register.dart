import 'package:firebase_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          child: Container(
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
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        TextField(
                          controller: emailcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: usernamecontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: passwordcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            errorText:
                                validatePassword(passwordcontroller.text),
                            errorStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
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
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            errorText:
                                validatePassword(cnfpasswardcontroller.text),
                            errorStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(width: 2.0, color: Colors.black),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 200.0,
                          height: 50.0,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.lock_open),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 135, 117),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            label: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account,",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            InkWell(
                              child: Text(
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
                                        builder: (context) => Login()));
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
}
