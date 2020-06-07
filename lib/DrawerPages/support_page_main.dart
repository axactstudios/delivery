import 'package:delivery/DrawerPages/support_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Have any complaint? ',
          style: TextStyle(color: Color(0xFF345995)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF345995),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage('images/hello.png'),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "How can we help you?",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
                "It looks like you are having some problems with the app or you want to request some material or videos. We are here to help so please get in touch with us",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  FlutterOpenWhatsapp.sendSingleMessage(
                      "919027553376", "Hello");
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Card(
                    elevation: 20.0,
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
                    elevation: 20.0,
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
          )
        ],
      ),
    );
  }
}
