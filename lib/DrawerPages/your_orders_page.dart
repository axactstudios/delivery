import 'package:flutter/material.dart';

class YourOrders extends StatefulWidget {
  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Past Orders',
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
        child: Center(child: Text('Your past orders will be displayed here')),
      ),
    );
  }
}
