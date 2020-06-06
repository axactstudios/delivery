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
  FirebaseUser user1;
  String name, address, pincode;

  void getUserDetails() async {
    String user = "+91${widget.phno}";

    DatabaseReference userref =
        await FirebaseDatabase.instance.reference().child('Users').child(user);
    userref.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      name = DATA['Name'];
      address = ' ${DATA['Addressline1']} \n ${DATA['Addressline2']}';
      pincode = DATA['pincode'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var pHeight = MediaQuery.of(context).size.height;
    var pWidth = MediaQuery.of(context).size.width;

    getUserDetails();
    print('------------------------${address}-------------------------------');
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
              children: <Widget>[
                Container(
                  height: pHeight / 2.5,
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('images/user.png'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: pWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Color(0xFF345995),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                color: Colors.white,
                              ),
                              child: Text(
                                name,
                                style: TextStyle(
                                    color: Color(0xFF345995),
                                    fontFamily: 'sf_pro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  "Address- \n$address \n $pincode",
                                  style: TextStyle(
                                      color: Color(0xFF345995),
                                      fontFamily: 'sf_pro',
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
