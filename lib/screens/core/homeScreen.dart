import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/signInScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Firebase Email Auth"),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                auth.signOut();
                Navigator.pushReplacementNamed(
                  context,
                  SignInScreen.routeName,
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Text("Yo Mama So Fat Thanos Had To Clap"),
        ),
      ),
    );
  }
}
