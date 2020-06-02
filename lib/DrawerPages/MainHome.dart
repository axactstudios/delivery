import 'package:delivery/Classes/categories.dart';
import 'package:delivery/Classes/Products.dart';
import 'package:delivery/LoginPages/WelcomeScreen.dart';
import 'package:delivery/bekarWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Cart/Cart.dart';
import 'developers_page.dart';
import 'support_page.dart';
import 'your_account_page.dart';
import 'your_orders_page.dart';

class MainHome extends StatefulWidget {
  final String phno;

  const MainHome({Key key, this.phno}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

final scaffoldState = GlobalKey<ScaffoldState>();

List<DailyNeeds> searchList = [];
List<DailyNeeds> recentSearchList = [];

double pWidth, pHeight;
var indexSelected = 1;

class _MainHomeState extends State<MainHome> {
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

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
      decoration: BoxDecoration(
        color: Color(0xFF345995),
      ),
      accountName: Text(
        'Welcome to Budget Mart',
        style: TextStyle(fontSize: 20),
      ),
      accountEmail: Text(" "),
      currentAccountPicture:
          CircleAvatar(child: Image.asset('images/welcome_ima ge.jpg')),
    );
    //Nav Drawer items
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Shop by Categories'),
          onTap: () => Navigator.pop(context, true),
        ),
        ListTile(
          title: Text('Your Orders'),
//        onTap: () => Navigator.of(context).push(_NewPage(1)),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => YourOrders())),
        ),
        ListTile(
            title: Text('Your Account'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => YourAccount(
                            phno: widget.phno,
                          )));
            }),
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
        ListTile(title: Text('Sign Out'), onTap: () => _signOut()),
      ],
    );
    pWidth = MediaQuery.of(context).size.width;
    pHeight = MediaQuery.of(context).size.height;

    if (indexSelected == 1) {
      return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            title: Text(
              "Budget Mart",
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: pHeight / 30,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
            iconTheme: IconThemeData(color: Color(0xFF345995)),
            backgroundColor: Colors.white,

            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    populateSearchList();
                    showSearch(context: context, delegate: DataSearch());
                  })
            ],
            // actions: <Widget>[
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 30),
//                child: GestureDetector(
//                  onTap: () {
////                    DatabaseReference userRef =
////                        FirebaseDatabase.instance.reference().child('Orders');
////                    for (int i = 0; i < _cartList.length; i++) {
////                      userRef.set({i: _cartList[i].name}).catchError(
////                          FlutterError.onError);
////                    }
//                    Navigator.of(context).push(
//                      MaterialPageRoute(
//                        builder: (context) => Cart(_cartList),
//                      ),
//                    );
//                  },
//                  child: Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.shoppingCart,
//                        size: pHeight / 35,
//                      ),
//                      if (_cartList.length > 0)
//                        Padding(
//                          padding: const EdgeInsets.only(left: 2.0),
//                          child: CircleAvatar(
//                            radius: 8.0,
//                            backgroundColor: Colors.red,
//                            foregroundColor: Colors.white,
//                            child: Text(
//                              _cartList.length.toString(),
//                              style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 12.0,
//                              ),
//                            ),
//                          ),
//                        ),
//                    ],
//                  ),
//                ),
//              ),
            //    ],
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
            title: Text(
              "Budget Mart",
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: pHeight / 30,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
            iconTheme: IconThemeData(color: Color(0xFF345995)),
            backgroundColor: Colors.white,
//            actions: <Widget>[
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 30),
//                child: GestureDetector(
//                  onTap: () {
//                    if (_cartList.isNotEmpty)
//                      Navigator.of(context).push(
//                        MaterialPageRoute(
//                          builder: (context) => Cart(_cartList),
//                        ),
//                      );
//                  },
//                  child: Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Icon(
//                        FontAwesomeIcons.shoppingCart,
//                        size: pHeight / 35,
//                      ),
//                      if (_cartList.length > 0)
//                        Padding(
//                          padding: const EdgeInsets.only(left: 2.0),
//                          child: CircleAvatar(
//                            radius: 8.0,
//                            backgroundColor: Colors.red,
//                            foregroundColor: Colors.white,
//                            child: Text(
//                              _cartList.length.toString(),
//                              style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 12.0,
//                              ),
//                            ),
//                          ),
//                        ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(
                      color: Color(0xFF345995),
                      fontSize: pHeight / 21,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
//                    DatabaseReference userRef =
//                        FirebaseDatabase.instance.reference().child('Orders');
//                    for (int i = 0; i < _cartList.length; i++) {
//                      userRef.set({i: _cartList[i].name}).catchError(
//                          FlutterError.onError);
//                    }
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
    );
  }

  Widget retClothes() {
    return Container(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(
                      color: Color(0xFF345995),
                      fontSize: pHeight / 21,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
//                    DatabaseReference userRef =
//                        FirebaseDatabase.instance.reference().child('Orders');
//                    for (int i = 0; i < _cartList.length; i++) {
//                      userRef.set({i: _cartList[i].name}).catchError(
//                          FlutterError.onError);
//                    }
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
    );
  }

  Widget retDailyNeeds() {
    return Container(
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
    );
  }

  void getDailyNeedItemRef() {
    DatabaseReference dailyitemsref =
        FirebaseDatabase.instance.reference().child('Daily needs');
    dailyitemsref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
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
    DatabaseReference categoriesref =
        FirebaseDatabase.instance.reference().child('Categories');
    categoriesref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
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
    DatabaseReference clothesref =
        FirebaseDatabase.instance.reference().child('Clothes');
    clothesref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
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

  void populateSearchList() {
    DatabaseReference clothesref =
        FirebaseDatabase.instance.reference().child('Clothes');
    clothesref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      searchList.clear();

      for (var key in KEYS) {
        DailyNeeds b = new DailyNeeds(
            DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
        searchList.add(b);
      }
    });

    DatabaseReference dailyitemsref =
        FirebaseDatabase.instance.reference().child('Daily needs');
    dailyitemsref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;

      for (var key in KEYS) {
        DailyNeeds d = new DailyNeeds(
            DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
        searchList.add(d);
      }
    });
    setState(() {
      print(searchList.length);
    });
    recentSearchList.clear();
    for (int i = 0; i < 5; i++) {
      recentSearchList.add(searchList[i]);
    }
  }

  // ignore: non_constant_identifier_names
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
                height: pWidth / 3.5,
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
                            fontSize: pHeight / 50),
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

  // ignore: non_constant_identifier_names
  Widget UICat(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      child: InkWell(
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
                        fontSize: pHeight / 55),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
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
                      _cartList.add(d);
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

class DataSearch extends SearchDelegate<String> {
  String itemSelectedName;
  @override
  List<Widget> buildActions(BuildContext context) {
// Actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    //show some result based on selection

//    return Container(
//      height: 100,
//      width: 100,
//      child: Card(
//        color: Colors.teal,
//        child: Text(itemSelectedName),
//      ),
//    );

    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    List<DailyNeeds> showList = [];
//    final showList = query.isEmpty ? recentSearchList : searchList;
    if (query.isEmpty) {
      showList = recentSearchList;
    } else {
      List<DailyNeeds> temp = [];
      print(searchList.length.toString());
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].name.startsWith(query)) {
          temp.add(searchList[i]);
        }
      }
      showList = temp;
    }

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          itemSelectedName = showList[index].name;
          showResults(context);
        },
//        title: Text(showList[index].name),
        title: RichText(
            text: TextSpan(
                text: showList[index].name.substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: showList[index].name.substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: showList.length,
    );
    throw UnimplementedError();
  }
}
