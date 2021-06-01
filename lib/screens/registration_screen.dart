import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/widgets/RoundButton.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  static const id = 'registration_Screen';
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email, password;
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: LoadingOverlay(
          isLoading: showSpinner,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
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
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
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
                    text: 'Register',
                    colorsend: Colors.blueAccent,
                    onTap: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        showSpinner = false;
                      } catch (e) {
                        print(e);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
