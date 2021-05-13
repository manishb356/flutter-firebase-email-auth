import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/resetPasswordScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/signInScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/signUpScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/splashScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/verifyEmailScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/core/homeScreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => SplashScreen());
      break;
    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (context) => SignInScreen());
      break;
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
      break;
    case VerifyEmailScreen.routeName:
      return MaterialPageRoute(builder: (context) => VerifyEmailScreen());
      break;
    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
      break;
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => HomeScreen());
      break;
  }
  return MaterialPageRoute(builder: (context) => SplashScreen());
}
