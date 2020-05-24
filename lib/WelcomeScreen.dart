import 'package:delivery/create_login.dart';
import 'package:delivery/menu_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 40.0, 0, 0),
                child: Text(
                  'Sidd Bro Cafe',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFFF24C00),
                      fontSize: 40,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 7.0, 0, 0),
                child: Text(
                  'Providing quality food at your doorstep',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFF787878),
                    fontSize: 25,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 38, 0, 0),
                child: Image.asset(
                  'images/welcome_image.png',
                  width: (MediaQuery.of(context).size.width),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 44.0, 0, 0),
                child: Text(
                  'Lets Get \nStarted',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFFF24C00),
                      fontSize: 40,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: goToLogin,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26.0),
                    child: Container(
                      width: 330,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFFF24C00),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'sf_pro'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: goToHomePage1,
                child: Center(
                  child: Text(
                    'Skip this step',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'sf_pro',
                      color: Color(0xFF787878),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return new MaterialApp(
        home: MenuFrame(),
      );
    }));
  }

  void goToHomePage1() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return new MaterialApp(
        home: HomePage1(),
      );
    }));
  }
}
