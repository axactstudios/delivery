import 'package:delivery/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: <Widget>[
            Text(
              'CREATE YOUR LOGIN',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
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
                    color: Colors.white,
                  ),
                ),
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
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
                    color: Colors.white,
                  ),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              onChanged: (textValue) {
                setState(() {
                  passwordConfirm = textValue;
                });
              },
              autovalidate: saveAttempt,
              validator: (pwConfrmValue) =>
                  pwConfrmValue != password ? 'Passwords do not match' : null,
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Re-type Password',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//              Text('CANCEL',
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold)),
//              SizedBox(
//                width: 30.0,
//              ),
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
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 34.0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
