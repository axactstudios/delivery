import 'package:delivery/DrawerPages/support_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Developers extends StatefulWidget {
  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Developers ',
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
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'images/web-development.png',
                height: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                'images/axact2.png',
                height: 150,
                colorBlendMode: BlendMode.colorBurn,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Got an idea that needs to enter the competitive world of apps and websites?',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: 20,
                    fontFamily: 'sf_pro'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Text(
                'Let Us Know',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: 24,
                    fontFamily: 'sf_pro'),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    FlutterOpenWhatsapp.sendSingleMessage(
                        "917060222315", "Hello");
                  },
                  child: Card(
                    elevation: 7.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.whatsapp,
                            size: 40.0,
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Contact Us Now",
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
