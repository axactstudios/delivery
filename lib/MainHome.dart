import 'package:delivery/Support.dart';
import 'package:delivery/WelcomeScreen.dart';
import 'package:delivery/YourAccount.dart';
import 'package:delivery/categories.dart';
import 'package:delivery/dailyneeds.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

double pWidth, pHeight;
var indexSelected = 1;

class _MainHomeState extends State<MainHome> {
  List<Categories> categories = [];
  List<DailyNeeds> dailyneeds = [];
  List<DailyNeeds> clothes = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference dailyitemsref =
        FirebaseDatabase.instance.reference().child('Daily needs');
    dailyitemsref.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      dailyneeds.clear();
      for (var key in KEYS) {
        DailyNeeds d = new DailyNeeds(
            DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
        dailyneeds.add(d);
      }
      setState(() {
        print(dailyneeds.length);
      });
    });
    DatabaseReference categoriesref =
        FirebaseDatabase.instance.reference().child('Categories');
    categoriesref.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      categories.clear();
      for (var key in KEYS) {
        Categories c = new Categories(DATA[key]['ImageUrl'], DATA[key]['Name']);
        categories.add(c);
      }
      setState(() {
        print(categories.length);
      });
    });
    DatabaseReference clothesref =
        FirebaseDatabase.instance.reference().child('Clothes');
    clothesref.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      clothes.clear();
      for (var key in KEYS) {
        DailyNeeds b = new DailyNeeds(
            DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
        clothes.add(b);
      }
      setState(() {
        print(clothes.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Shubh Saraswat'),
      accountEmail: Text('shubhsaras@axact.com'),
      currentAccountPicture:
          CircleAvatar(child: Image.asset('images/shubh.jpg')),
    );
    final drawerItems = ListView(
      children: <Widget>[
        ListTile(
          title: Text('Shop by Categories'),
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHome())),
        ),
        ListTile(
          title: Text('Your Orders'),
//        onTap: () => Navigator.of(context).push(_NewPage(1)),
        ),
        ListTile(
          title: Text('Your Account'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => YourAccount())),
        ),
        ListTile(
          title: Text('Support'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Support())),
        ),
        ListTile(
          title: Text('Developers'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Sign Out'),
          onTap: () {},
        ),
      ],
    );
    pWidth = MediaQuery.of(context).size.width;
    pHeight = MediaQuery.of(context).size.height;

    if (indexSelected == 1) {
      return Scaffold(
          drawer: Drawer(
            child: drawerItems,
          ),
//          appBar: AppBar(
//            elevation: 0,
//            backgroundColor: Colors.white,
//            leading: Icon(
//              Icons.menu,
//              color: Colors.deepPurpleAccent,
//            ),
//          ),
          body: retDailyNeedsPage());
    } else {
      return Scaffold(
          drawer: Drawer(
            child: drawerItems,
          ),
          body: retClothesPage());
    }
  }

  Widget retDailyNeeds() {
    return Container(
      height: pHeight / 2,
//              child: ListView(
//                scrollDirection: Axis.horizontal,
//                children: groceriesSelected,
//              ),
      child: dailyneeds.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: dailyneeds.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return UI(dailyneeds[index].name, dailyneeds[index].imageUrl,
                    dailyneeds[index].price);
              },
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10.0),
            ),
    );
  }

  Widget retClothes() {
    return Container(
      height: pHeight / 2,
//              child: ListView(
//                scrollDirection: Axis.horizontal,
//                children: groceriesSelected,
//              ),
      child: clothes.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: clothes.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return UI(clothes[index].name, clothes[index].imageUrl,
                    clothes[index].price);
              },
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10.0),
            ),
    );
  }

  Widget retDailyNeedsPage() {
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
                child: categories.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                indexSelected = index;
                                print(indexSelected.toString());
                              });
                            },
                            child: UICat(categories[index].name,
                                categories[index].imageUrl),
                          );
                        },
                      )),
            SizedBox(
              height: 25,
            ),
            Text(
              'Available Items',
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: 30,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            retDailyNeeds()
          ],
        ),
      ),
    );
  }

  Widget retClothesPage() {
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
                child: categories.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                indexSelected = index;
                                print(indexSelected.toString());
                              });
                            },
                            child: UICat(categories[index].name,
                                categories[index].imageUrl),
                          );
                        },
                      )),
            SizedBox(
              height: 25,
            ),
            Text(
              'Available Items',
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: 30,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            retClothes()
          ],
        ),
      ),
    );
  }
}

Widget UI(String name, String imageUrl, int price) {
  return Padding(
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
            width: (pWidth - 100),
            height: (pHeight - 100) / 5 - 3,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'sf_pro',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Text(
                    "Rs. ${price.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'sf_pro',
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget UICat(String name, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: InkWell(
//      onTap: ShowItems,
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
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'sf_pro', color: Colors.white, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

void ShowItems() {
  print('HEllo');
}
