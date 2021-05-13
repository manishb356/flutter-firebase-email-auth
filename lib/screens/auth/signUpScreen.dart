import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/signInScreen.dart';
import 'package:flutter_firebase_email_auth_starter_kit/screens/auth/verifyEmailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email, _password, _name;
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "Name"),
                onChanged: (value) {
                  setState(() {
                    _name = value.trim();
                  });
                },
                validator: (value) => value != null ? null : "Required",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "Email"),
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
                      onPressed: () => _signup(_email, _password),
                      child: _isLoading
                          ? Container(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : Text("Sign Up"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      SignInScreen.routeName,
                    );
                  },
                  child: Text("Sign In Instead"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _signup(String _email, String _password) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        User user = auth.currentUser;

        await firestore.collection('users').doc(user.uid).set({
          "email": _email,
          "name": _name,
        });

        await user.sendEmailVerification();

        auth.currentUser.updateProfile(displayName: _name);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification Mail sent to ${user.email}")));

        Navigator.pushReplacementNamed(
          context,
          VerifyEmailScreen.routeName,
        );
      } on FirebaseAuthException catch (error) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }
}
