import 'package:delivery/DrawerPages/MainHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OTPScreen.dart';

class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isValid = false;

  Future<Null> validate() async {
    if (_phoneNumberController.text.length == 10) {
      setState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF345995),
      body: Container(
        color: Color(0xFF345995),
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Phone Authentication',
                style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: pHeight / 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 10),
              child: Text(
                'Link your phone number to your account',
                style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontSize: pHeight / 45,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _phoneNumberController,
                        autofocus: true,
                        onChanged: (text) {
                          validate();
                        },
                        decoration: InputDecoration(
                          labelText: "10 digit mobile number",
                          prefix: Container(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "+91",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        autovalidate: true,
                        autocorrect: false,
                        maxLengthEnforced: true,
                        validator: (value) {
                          return !isValid
                              ? 'Please provide a valid 10 digit phone number'
                              : null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: RaisedButton(
                            color: !isValid ? Color(0xFF345995) : Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Text(
                              !isValid ? "ENTER PHONE NUMBER" : "CONTINUE",
                              style: !isValid
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (isValid) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OTPScreen(
                                        mobileNumber:
                                            _phoneNumberController.text,
                                      ),
                                    ));
                              } else {
                                validate();
                              }
                            },
                            padding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
