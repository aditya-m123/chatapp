import 'package:flutter/material.dart';
import 'package:chatapp/widgets/RoundButton.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
                text: 'Log In',
                colorsend: Colors.blueAccent,
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final oldUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (oldUser != null) {
                      Navigator.pushNamedAndRemoveUntil(context, ChatScreen.id,
                          (Route<dynamic> route) => false);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
