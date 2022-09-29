import 'package:firebase_app/screens/home.dart';
import 'package:firebase_app/screens/login.dart';
import 'package:firebase_app/utils/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Spinner();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
