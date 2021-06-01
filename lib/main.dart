import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/welcome_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute:
            _auth.currentUser != null ? ChatScreen.id : WelcomeScreen.id,
        routes: {
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
        });
  }
}
