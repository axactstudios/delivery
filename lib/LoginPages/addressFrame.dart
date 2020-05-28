import 'dart:ui';

import 'package:delivery/LoginPages/address.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressFrame extends StatelessWidget {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF24C00),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height / 6,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Enter Primary Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40.0,
                            fontFamily: 'sf_pro'),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: PageView(
                          controller: pageController,
                          children: <Widget>[Address()],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 6,
              ),
            ],
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
