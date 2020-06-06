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
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 10,
                child: Image.asset('images/logo_axact.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Axact Studios',
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFF345995),
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Design.Code.Create',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF345995),
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    FlutterOpenWhatsapp.sendSingleMessage(
                        "917060222315", "Hello");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
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
                              "Chat with us",
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Support())),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Card(
                      elevation: 7.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 39.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.mailBulk,
                              size: 40.0,
                              color: Color.fromARGB(255, 143, 23, 255),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Email us",
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
