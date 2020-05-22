import 'package:delivery/create_login.dart';
import 'package:delivery/menu_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: goToLogin,
              child: Card(
                color: Colors.blue,
                child: Text("Continue"),
              ),
            ),
          ],
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
}
