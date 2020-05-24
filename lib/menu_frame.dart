import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:delivery/Signin.dart';

import 'create_login.dart';

class MenuFrame extends StatelessWidget {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFFF24C00),
      home: Material(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 60, 0, 0),
                  child: Text(
                    'Enter your \ncredentials',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF24C00),
                      fontFamily: 'sf_pro',
                      fontSize: 40.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: <Widget>[
                      SignIn(),
                      CreateLogin(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
//gradient: LinearGradient(
//begin: Alignment.topCenter,
//end: Alignment.bottomCenter,
//colors: [
//Color.fromRGBO(255, 89, 89, 1.0),
//Color.fromRGBO(133, 113, 255, 1.0),
//],
