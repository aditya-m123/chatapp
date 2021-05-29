import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:chatapp/widgets/RoundButton.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  height: 45,
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Flash Card',
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                text: 'Log In',
                colorsend: Colors.lightBlueAccent),
            RoundButton(
              onTap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
              colorsend: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
