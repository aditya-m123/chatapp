import 'dart:ui';

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton(
      {required this.onTap, required this.text, required this.colorsend});

  final Function onTap;
  final String text;
  final Color colorsend;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color: colorsend,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: () => onTap(),
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
