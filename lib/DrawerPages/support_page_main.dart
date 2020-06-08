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

  double pWidth, pHeight;
  @override
  Widget build(BuildContext context) {
    pHeight = MediaQuery.of(context).size.height;
    pWidth = MediaQuery.of(context).size.width;
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
            height: pHeight / 2.5,
          ),
          SizedBox(
            height: pHeight / 50,
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
          SizedBox(
            height: pHeight / 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
                "If you have any complaint regarding any product or service feel free"
                "to contact us. Your problem will be taken into consideration as soon as possible",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: pHeight / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  FlutterOpenWhatsapp.sendSingleMessage(
                      "919027553376", "Hello");
                },
                child: SizedBox(
                  height: pHeight / 6.5,
                  width: pWidth / 3,
                  child: Card(
                    elevation: 7.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, right: 8),
                            child: Icon(
                              FontAwesomeIcons.whatsapp,
                              size: pHeight / 25.0,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            height: pHeight / 70,
                          ),
                          Text(
                            "Chat with us",
                            style: TextStyle(fontSize: pHeight / 60),
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
                child: SizedBox(
                  height: pHeight / 6.5,
                  width: pWidth / 3,
                  child: Card(
                    elevation: 7.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, right: 8),
                            child: Icon(
                              FontAwesomeIcons.mailBulk,
                              size: pHeight / 25.0,
                              color: Color.fromARGB(255, 143, 23, 255),
                            ),
                          ),
                          SizedBox(
                            height: pHeight / 70,
                          ),
                          Text(
                            "Email Us",
                            style: TextStyle(fontSize: pHeight / 60),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
