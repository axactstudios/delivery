import 'package:delivery/LoginPages/PhoneLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DrawerPages/MainHome.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    pHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: pHeight / 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                child: Text(
                  'Budget Mart',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF345995),
                      fontSize: pHeight / 20,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: pHeight / 70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                child: Text(
                  'Providing quality products at your doorstep',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFF787878),
                    fontSize: 25,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
              SizedBox(
                height: pHeight / 35,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Image.asset(
                  'images/welcome_image.png',
                  width: (MediaQuery.of(context).size.width),
                  height: pHeight / 2.75,
                ),
              ),
              SizedBox(
                height: pHeight / 35,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                child: Text(
                  'Lets Get \nStarted',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF345995),
                      fontSize: 40,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: pHeight / 40,
              ),
              InkWell(
                onTap: goToLogin,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Container(
                      width: 330,
                      height: pHeight / 15,
                      decoration: BoxDecoration(
                        color: Color(0xFF345995),
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
                              fontSize: pHeight / 27,
                              fontFamily: 'sf_pro'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: pHeight / 40,
              ),
              InkWell(
                onTap: goToHomePage1,
                child: Center(
                  child: Text(
                    'Skip this step',
                    style: TextStyle(
                      fontSize: pHeight / 40,
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
    Navigator.push(context, SlideUpRoute(nextPage: PhoneLogin()));
  }

  void goToHomePage1() {
    Navigator.push(context, SlideUpRoute(nextPage: MainHome()));
  }
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget nextPage;
  SlideUpRoute({this.nextPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              nextPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
