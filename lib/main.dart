import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/welcome_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomeScreen.id, routes: {
      RegistrationScreen.id: (context) => RegistrationScreen(),
      ChatScreen.id: (context) => ChatScreen(),
      WelcomeScreen.id: (context) => WelcomeScreen(),
      LoginScreen.id: (context) => LoginScreen(),
    });
  }
}
