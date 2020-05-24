import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

double pWidth;

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    pWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Categories',
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: 40,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 140.0,
//              child: ListView(
//                scrollDirection: Axis.horizontal,
//                children: groceriesSelected,
//              ),
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctxt, int index) =>
                      buildCategories(ctxt, index)),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Available Groceries',
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: 30,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 140.0,
//              child: ListView(
//                scrollDirection: Axis.horizontal,
//                children: groceriesSelected,
//              ),
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctxt, int index) =>
                      buildMenu(ctxt, index)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategories(BuildContext ctxt, int index) {
    return categories[index];
  }

  Widget buildMenu(BuildContext ctxt, int index) {
    return groceries[index];
  }
}

List<Widget> categories = [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 3,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 3,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Groceries',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 3,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 3,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Food',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 3,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 3,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Clothes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 3,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 3,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Others',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
];

List<Widget> groceries = [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 2,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 2,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Groceries',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 2,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 2,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Food',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 2,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 2,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Clothes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 2,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            width: (pWidth - 100) / 2,
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Others',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'sf_pro', color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ),
  ),
];
