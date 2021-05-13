import 'package:flutter_firebase_email_auth_starter_kit/screens/core/homeScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/signInScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/verifyEmailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;
  bool isUser = false;

  @override
  void initState() {
    _handleStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _handleStart() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.pushReplacementNamed(
          context,
          SignInScreen.routeName,
        );
      } else {
        if (user.emailVerified) {
          Navigator.pushReplacementNamed(
            context,
            HomeScreen.routeName,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            VerifyEmailScreen.routeName,
          );
        }
      }
    });
  }
}
