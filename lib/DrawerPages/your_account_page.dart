import 'package:delivery/LoginPages/PhoneLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourAccount extends StatefulWidget {
  @override
  _YourAccountState createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Your Account Info',
            style: TextStyle(color: Color(0xFF345995)),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF345995),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Phone no. - ${user.phoneNumber}"),
                Text("Your budget mart id - ${user.uid}"),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneLogin())),
                child: Card(
                  elevation: 50,
                  child: Text('Sign Up'),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
