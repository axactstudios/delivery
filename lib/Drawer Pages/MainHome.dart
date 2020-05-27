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
            title: Padding(
              padding: const EdgeInsets.all(35),
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
                  alignment: Alignment.topCenter,
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
            title: Padding(
              padding: const EdgeInsets.all(35),
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
                  alignment: Alignment.topCenter,
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
          ),
          drawer: Drawer(
            key: _drawerKey,
            child: drawerItems,
          ),
          body: retClothesPage());
    }
  }

  Widget retDailyNeeds() {
    return Container(
      height: (pHeight / 2.25),
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
      height: (pHeight / 2.25),
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
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: 40,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
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
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'Available Items',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: 30,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: retDailyNeeds(),
            )
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
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: 40,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
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
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'Available Items',
                style: TextStyle(
                    color: Color(0xFF345995),
                    fontSize: 30,
                    fontFamily: 'sf_pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: retClothes(),
            )
          ],
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
                height: (pHeight - 100) / 6.1,
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

    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(name),
          ),
          Container(
            child: Image.network(imageUrl),
          ),
          Container(
            child: Text(price.toString()),
          ),
          InkWell(
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
              child: Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
