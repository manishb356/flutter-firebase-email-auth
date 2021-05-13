import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_auth_starter_kit/services/navigation.dart'
    as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.amberAccent,
      ),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: router.generateRoute,
    );
  }
}
