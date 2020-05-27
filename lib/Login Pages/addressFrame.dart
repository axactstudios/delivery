import 'dart:ui';

import 'package:delivery/Login%20Pages/address.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressFrame extends StatelessWidget {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'delivery',
      home: Material(
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 100.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'delivery',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 34.0),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.key,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      Text('Enter Addres',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24.0)),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: <Widget>[Address()],
                    ),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
