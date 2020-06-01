import 'dart:ui';

import 'package:delivery/LoginPages/address.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddressFrame extends StatelessWidget {
  final String phno;

  AddressFrame({Key key, this.phno}) : super(key: key);
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF345995),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
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
                    children: <Widget>[
                      Address(
                        phno: this.phno,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
