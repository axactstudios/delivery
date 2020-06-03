import 'package:delivery/LoginPages/PhoneLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourAccount extends StatefulWidget {
  final String phno;

  const YourAccount({Key key, this.phno}) : super(key: key);
  @override
  _YourAccountState createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user1;
  String name, address, pincode;

  void getUserDetails() {
    String user = widget.phno;
//    String user = '+917060222315';
    print(widget.phno);
    DatabaseReference userref =
        FirebaseDatabase.instance.reference().child('Users').child(user);
    userref.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      name = DATA['Name'];
      address = DATA['Addressline1'] + DATA['Addressline2'];
      pincode = DATA['pincode'];
    });
  }

//  void getCurrentUser() async {
//    FirebaseUser _user = await _firebaseAuth.currentUser();
//    user1 = _user;
//    setState(() {
//      user1 = _user;
//      if (user1 == null) {
//        print('User is null');
//      } else {
//        print(user1.displayName);
//      }
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
////    getCurrentUser();
////    String user = user1.phoneNumber.toString();
//    String user = '+91${widget.phno}';
//    DatabaseReference userref =
//        FirebaseDatabase.instance.reference().child('Users').child(user);
//    userref.once().then((DataSnapshot snap) {
//      var DATA = snap.value;
//      name = DATA['Name'];
//      address = DATA['Addressline1'] + DATA['Addressline2'];
//      pincode = DATA['pincode'];
//    });
//  }

  @override
  Widget build(BuildContext context) {
    getUserDetails();
    if (widget.phno != null) {
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
                Text(name),
                Text("Address- $address"),
                Text('Pincode- $pincode'),
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
