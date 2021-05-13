import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/resetPasswordScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/signUpScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/verifyEmailScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/core/homeScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email, _password;
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Fluuter Firebase Email Auth",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "Email",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                  validator: (value) => EmailValidator.validate(value)
                      ? null
                      : "Enter a valid email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "Password",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                  validator: (value) => value.length > 5
                      ? null
                      : "Password should be at least 6 characters",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                        ),
                        onPressed: () => _signin(_email, _password),
                        child: _isLoading
                            ? Container(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : Text("Sign In"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ResetPasswordScreen.routeName);
                    },
                    child: Text("Forgot Password?"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignUpScreen.routeName,
                      );
                    },
                    child: Text("Sign Up Instead"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signin(String _email, String _password) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        User user = auth.currentUser;
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
      } on FirebaseAuthException catch (error) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
  }
}
