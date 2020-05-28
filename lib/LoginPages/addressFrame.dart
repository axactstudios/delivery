import 'dart:ui';

import 'package:delivery/LoginPages/address.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddressFrame extends StatelessWidget {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    double pheight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF24C00),
        body: SafeArea(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//              SizedBox(
//                height: pheight / 10,
//              ),
                Column(
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
                SizedBox(
                  height: pheight / 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
