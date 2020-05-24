import 'package:delivery/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'PhoneLogin.dart';

class CreateLogin extends StatefulWidget {
  @override
  _CreateLoginState createState() => _CreateLoginState();
}

class _CreateLoginState extends State<CreateLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password, passwordConfirm;
  bool saveAttempt = false;
  final formKey = GlobalKey<FormState>();

  void _createUser(String email, String pw) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pw)
        .then((authResult) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return new MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
          ),
          home: PhoneLogin(),
        );
      }));
    }).catchError((err) {
      print(err);
      if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('This email is already in use'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromRGBO(254, 61, 0, 0.77),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Text(
                'Create an account',
                style: TextStyle(
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 35.0),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.accusoft,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          email = textValue;
                        });
                      },
                      autovalidate: saveAttempt,
                      validator: (emailValue) {
                        if (emailValue.isEmpty) {
                          return 'This field cannot be blank';
                        }
                        RegExp regExp = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (regExp.hasMatch(emailValue)) {
                          return null;
                        }

                        return 'Please enter a valid email';
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontFamily: 'sf_pro'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.accusoft,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          password = textValue;
                        });
                      },
                      autovalidate: saveAttempt,
                      validator: (pwValue) =>
                          pwValue.isEmpty ? 'This field cannot be blank' : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 20),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontFamily: 'sf_pro'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          passwordConfirm = textValue;
                        });
                      },
                      autovalidate: saveAttempt,
                      validator: (pwConfrmValue) => pwConfrmValue != password
                          ? 'Passwords do not match'
                          : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Re-type Password',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                          fontFamily: 'sf_pro',
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'sf_pro',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  saveAttempt = true;
                });
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  _createUser(email, password);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 34.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    'Create',
                    style: TextStyle(
                        color: Color(0xFF606060),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sf_pro'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
