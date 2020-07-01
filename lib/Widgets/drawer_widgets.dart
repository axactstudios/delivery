import 'package:delivery/DrawerPages/PrivacyPolicy.dart';
import 'package:delivery/DrawerPages/developers_page.dart';
import 'package:delivery/DrawerPages/support_page_main.dart';
import 'package:delivery/DrawerPages/your_account_page.dart';
import 'package:delivery/DrawerPages/your_orders_page.dart';
import 'package:delivery/LoginPages/PhoneLogin.dart';
import 'package:delivery/LoginPages/WelcomeScreen.dart';
import 'package:delivery/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getDrawerHeader(User userData, BuildContext context) {
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(
      color: Color(0xFF345995),
    ),
    accountName: userData.name !=
            null //Testing if the user is logged in or not using the UID
        ? Text(
            userData.name, //Replaced name with userData.name
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'sf_pro',
            ),
          )
        : Text(
            'You are not logged in',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'sf_pro',
            ),
          ),
    accountEmail: userData.name !=
            null //Testing if the user is logged in or not using the UID
        ? Text(userData.number) //Replaced widget.phno with userData.number
        : InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhoneLogin()),
              );
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'sf_pro',
              ),
            )),
    currentAccountPicture: CircleAvatar(
      child: Image.asset('images/user.png'),
    ),
  );
}

Widget getDrawerItems(User userData, BuildContext context) {
  return ListView(
    children: <Widget>[
      getDrawerHeader(userData, context),
      ListTile(
        title: Text(
          'Shop by Categories',
          style: TextStyle(
            color: Color(0xFF345995),
            fontFamily: 'sf_pro',
            fontSize: 20,
          ),
        ),
        onTap: () => Navigator.pop(context, true),
      ),
      ListTile(
        title: Text(
          'Your Orders',
          style: TextStyle(
            color: Color(0xFF345995),
            fontFamily: 'sf_pro',
            fontSize: 20,
          ),
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => YourOrders(
                      phno: userData
                          .number, //Replaced widget.phno with userData.number
                    ))),
      ),
      ListTile(
          title: Text(
            'Your Account',
            style: TextStyle(
              color: Color(0xFF345995),
              fontFamily: 'sf_pro',
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => YourAccount(
                        phno: userData
                            .number //Replaced widget.phno with userData.number
                        )));
          }),
      ListTile(
        title: Text(
          'Support',
          style: TextStyle(
            color: Color(0xFF345995),
            fontFamily: 'sf_pro',
            fontSize: 20,
          ),
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactUsPage())),
      ),
      ListTile(
        title: Text(
          'Developers',
          style: TextStyle(
            color: Color(0xFF345995),
            fontFamily: 'sf_pro',
            fontSize: 20,
          ),
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Developers())),
      ),
      ListTile(
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xFF345995),
            fontFamily: 'sf_pro',
            fontSize: 20,
          ),
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
      ),
      ListTile(
          title: Text(
            'Sign Out',
            style: TextStyle(
              color: Color(0xFF345995),
              fontFamily: 'sf_pro',
              fontSize: 20,
            ),
          ),
          onTap: () {
            userData.number != null //Replaced widget.phno with userData.number
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Sign Out"),
                        content: Text(
                            "Are you sure you want to sign out?\nItems in your cart wil be cleared if you do so."),
                        actions: [
                          FlatButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text("Sign Out"),
                            onPressed: () {
                              _signOut(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()));
                            },
                          )
                        ],
                      );
                    })
                : showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Sign Out"),
                        content: Text("You need to be logged in first."),
                        actions: [
                          FlatButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
          }),
    ],
  );
}

void _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
}
