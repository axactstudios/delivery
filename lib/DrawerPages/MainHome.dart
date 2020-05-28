import 'package:delivery/Classes/categories.dart';
import 'package:delivery/Classes/Products.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Cart/Cart.dart';
import 'developers_page.dart';
import 'support_page.dart';
import 'your_account_page.dart';
import 'your_orders_page.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

final scaffoldState = GlobalKey<ScaffoldState>();

double pWidth, pHeight;
var indexSelected = 1;

class _MainHomeState extends State<MainHome> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Categories> categories = [];
  List<DailyNeeds> dailyneeds = [];
  List<DailyNeeds> clothes = [];
  List<DailyNeeds> _cartList = [];

  @override
  void initState() {
    super.initState();
    getCategoriesRef();
    getDailyNeedItemRef();
    getClothesRef();
  }

  @override
  Widget build(BuildContext context) {
    //Header for user information
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Shubh Saraswat'),
      accountEmail: Text('shubhsaras@axact.com'),
      currentAccountPicture:
          CircleAvatar(child: Image.asset('images/shubh.jpg')),
    );
    //Nav Drawer items
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Shop by Categories'),
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHome())),
        ),
        ListTile(
          title: Text('Your Orders'),
//        onTap: () => Navigator.of(context).push(_NewPage(1)),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => YourOrders())),
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
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Developers())),
        ),
        ListTile(
          title: Text('Sign Out'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => YourAccount())),
        ),
      ],
    );
    pWidth = MediaQuery.of(context).size.width;
    pHeight = MediaQuery.of(context).size.height;

    if (indexSelected == 1) {
      return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF345995)),
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    if (_cartList.isNotEmpty)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Cart(_cartList),
                        ),
                      );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        size: pHeight / 35,
                      ),
                      if (_cartList.length > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child: Text(
                              _cartList.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            key: _drawerKey,
            child: drawerItems,
          ),
          body: retDailyNeedsPage());
    } else {
      return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF345995)),
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    if (_cartList.isNotEmpty)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Cart(_cartList),
                        ),
                      );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        size: pHeight / 35,
                      ),
                      if (_cartList.length > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child: Text(
                              _cartList.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            key: _drawerKey,
            child: drawerItems,
          ),
          body: retClothesPage());
    }
  }

  Widget retClothesPage() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: pHeight / 21,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: pHeight / 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                  height: pHeight / 7,
                  child: categories.length == 0
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
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
            ),
            SizedBox(
              height: pHeight / 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'Available Items',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: pHeight / 30,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: pHeight / 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: pHeight / 1.95,
                child: retClothes(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget retClothes() {
    return Expanded(
      child: Container(
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
      ),
    );
  }

  Widget retDailyNeedsPage() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: pHeight / 21,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: pHeight / 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                  height: pHeight / 7,
                  child: categories.length == 0
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
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
            ),
            SizedBox(
              height: pHeight / 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'Available Items',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: pHeight / 30,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: pHeight / 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: pHeight / 1.95,
                child: retDailyNeeds(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget retDailyNeeds() {
    return Expanded(
      child: Container(
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
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0),
              ),
      ),
    );
  }

  //-------------------------------Firebase Reference Function----------------------------------//
  void getDailyNeedItemRef() {
    //Database reference for daily items
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
  }

  void getCategoriesRef() {
    //Database reference for categories items

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
  }

  void getClothesRef() {
    //Database reference for clothes items
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

  Widget UI(String name, String imageUrl, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      child: InkWell(
        onTap: () {
          scaffoldState.currentState.showBottomSheet((context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter state) {
              return UIDetails(name, imageUrl, price);
            });
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF345995),
            border: Border.all(color: Colors.black),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
//      width: (pWidth - 100) / 3,

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
                height: pWidth / 3.25,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
      ),
    );
  }

  Widget UICat(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      child: InkWell(
//      onTap: ShowItems,
        child: Container(
          height: pHeight / 7,
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
                height: pHeight / 9.5,
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
                        fontFamily: 'sf_pro',
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget UIDetails(String name, String imageUrl, int price) {
    DailyNeeds d = DailyNeeds(imageUrl, name, price);

    return Container(
      height: pHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color(0xFF345995),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: pHeight / 30,
            ),
            Container(
              color: Color(0xFF345995),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: pHeight / 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            SizedBox(
              height: pHeight / 30,
            ),
            Container(
              height: pHeight / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.network(
                  imageUrl,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(
              height: pHeight / 30,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Price-${price.toString()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: pHeight / 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
            ),
            Container(
              height: pHeight / 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Description-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: pHeight / 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: pHeight / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(
                    () {
                      if (!_cartList.contains(d)) {
                        _cartList.add(d);
                      } else {
                        _cartList.remove(d);
                      }
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontFamily: 'sf_pro',
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
