import 'package:flutter/material.dart';

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
            Text('Axact Studios'),
            Text('Visit our website'),
            Text('Need an app. Contact Now')
          ]),
        ),
      ),
    );
  }
}
