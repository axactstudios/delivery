import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Developers extends StatefulWidget {
  @override
  _DevelopersState createState() => _DevelopersState();
}

double pHeight, pWidth;

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    pHeight = MediaQuery.of(context).size.height;
    pWidth = MediaQuery.of(context).size.width;

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
            SizedBox(
              height: pHeight / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'images/Logo.png',
              ),
            ),
            SizedBox(
              height: pHeight / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'At Axact Studios we create your ideas into any digital platform be'
                ' it apps or websites.\nWe also provide UI/UX design and full'
                ' maintenance of the platform after the launch of the product.',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: pHeight / 40,
                    fontFamily: 'sf_pro'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Got an idea that needs to enter the competitive world of apps and websites?',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: pHeight / 40,
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
                    fontSize: pHeight / 35,
                    fontFamily: 'sf_pro'),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _launchURL1();
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
                                FontAwesomeIcons.telegramPlane,
                                size: pHeight / 25.0,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "Contact Us Now",
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
                  onPressed: () {
                    _launchURL();
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
                                FontAwesomeIcons.arrowAltCircleRight,
                                size: pHeight / 25.0,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "Visit Our Website",
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
          ]),
        ),
      ),
    );
  }

  _launchURL1() async {
//    const url = 'https://t.me/joinchat/ODJu0h3H5KdJmsR-bAK8Lg';
    const url = 'https://t.me/axactstudios';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    const url = 'https://google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
