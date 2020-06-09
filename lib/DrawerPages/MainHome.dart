import 'package:after_layout/after_layout.dart';
import 'package:delivery/Classes/categories.dart';
import 'package:delivery/Classes/Products.dart';
import 'package:delivery/Classes/dicounts.dart';
import 'package:delivery/DrawerPages/support_page_main.dart';
import 'package:delivery/LoginPages/PhoneLogin.dart';
import 'package:delivery/LoginPages/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Cart/Cart.dart';
import 'developers_page.dart';
import 'your_account_page.dart';
import 'your_orders_page.dart';

class MainHome extends StatefulWidget {
  final String phno;
  final bool onReturnedFromCart;
  final String itemToShow;
  final String urlToShow;
  final int priceToShow;

  const MainHome(
      {Key key,
      this.phno,
      this.onReturnedFromCart,
      this.itemToShow,
      this.urlToShow,
      this.priceToShow})
      : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

final scaffoldState = GlobalKey<ScaffoldState>();
List<DailyNeeds> searchList = [];
List<DailyNeeds> recentSearchList = [];

double pWidth, pHeight;
var indexSelected = 1;
List<DailyNeeds> _cartList = [];

class _MainHomeState extends State<MainHome> with AfterLayoutMixin<MainHome> {
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Categories> categories = [];
  List<DailyNeeds> dailyneeds = [];
  List<Discounts> discounts = [];
  List<DailyNeeds> clothes = [];

  @override
  void initState() {
    super.initState();
    getCategoriesRef();
    getDailyNeedItemRef();
    getClothesRef();
  }

  FirebaseUser user1;
  String name;

  void getUserName() async {
    String user = "+91${widget.phno}";

    DatabaseReference userref =
        await FirebaseDatabase.instance.reference().child('Users').child(user);
    userref.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      name = DATA['Name'];
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    if (widget.onReturnedFromCart == true) {
      _cartList.add(
          DailyNeeds(widget.urlToShow, widget.itemToShow, widget.priceToShow));
      showToast('Item added to cart', Colors.white);
      scaffoldState.currentState.showBottomSheet((context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return UIDetails(
              widget.itemToShow, widget.urlToShow, widget.priceToShow);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.phno != null ? getUserName() : null;
    //Header for user information
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xFF345995),
      ),
      accountName: widget.phno != null
          ? Text(
              name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'sf_pro',
              ),
            )
          : Text(
              'You are not logged in',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'sf_pro',
              ),
            ),
      accountEmail: widget.phno != null
          ? Text(widget.phno)
          : InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneLogin()));
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'sf_pro',
                ),
              )),
      currentAccountPicture: CircleAvatar(
        child: Image.asset('images/user.png'),
      ),
    );
    //Nav Drawer items
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text(
            'Shop by Categories',
            style: TextStyle(
              color: Color(0xFF345995),
              fontFamily: 'sf_pro',
              fontSize: 20,
            ),
          ),
          onTap: () => Navigator.pop(context, true),
        ),
        ListTile(
          title: Text(
            'Your Orders',
            style: TextStyle(
              color: Color(0xFF345995),
              fontFamily: 'sf_pro',
              fontSize: 20,
            ),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => YourOrders(
                        phno: widget.phno,
                      ))),
        ),
        ListTile(
            title: Text(
              'Your Account',
              style: TextStyle(
                color: Color(0xFF345995),
                fontFamily: 'sf_pro',
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => YourAccount(
                            phno: widget.phno,
                          )));
            }),
        ListTile(
          title: Text(
            'Support',
            style: TextStyle(
              color: Color(0xFF345995),
              fontFamily: 'sf_pro',
              fontSize: 20,
            ),
          ),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ContactUsPage())),
        ),
        ListTile(
          title: Text(
            'Developers',
            style: TextStyle(
              color: Color(0xFF345995),
              fontFamily: 'sf_pro',
              fontSize: 20,
            ),
          ),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Developers())),
        ),
        ListTile(
            title: Text(
              'Sign Out',
              style: TextStyle(
                color: Color(0xFF345995),
                fontFamily: 'sf_pro',
                fontSize: 20,
              ),
            ),
            onTap: () {
              widget.phno != null
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Sign Out"),
                          content: Text(
                              "Are you sure you want to sign out?\nItems in your cart wil be cleared if you do so."),
                          actions: [
                            FlatButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("Sign Out"),
                              onPressed: () {
                                _signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomeScreen()));
                              },
                            )
                          ],
                        );
                      })
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Sign Out"),
                          content: Text("You need to be logged in first."),
                          actions: [
                            FlatButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
            }),
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
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(_cartList, widget.phno),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        color: Color(0xFF345995),
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
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(_cartList, widget.phno),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        color: Color(0xFF345995),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: pHeight / 70,
          ),
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
              height: discounts.length == 0 ? pHeight / 1.95 : pHeight / 2.17,
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
          SizedBox(
            height: pHeight / 70,
          ),
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
              height: discounts.length == 0 ? pHeight / 1.95 : pHeight / 2.17,
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

  Widget retDiscounts() {
    discountref();
    return Expanded(
      child: Container(
        child: discounts.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: discounts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return UIDiscount(
                      discounts[index].name,
                      discounts[index].imageUrl,
                      discounts[index].category,
                      discounts[index].priceOrg,
                      discounts[index].priceNew);
                },
              ),
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
      setState(() {});
    });
  }

  void discountref() {
    DatabaseReference discountref =
        FirebaseDatabase.instance.reference().child('Discounts');
    discountref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      discounts.clear();
      for (var key in KEYS) {
        Discounts d = new Discounts(
            DATA[key]['ImageUrl'],
            DATA[key]['Category'],
            DATA[key]['Name'],
            DATA[key]['Original Price'],
            DATA[key]['Discounted Price']);
        discounts.add(d);
      }
      setState(() {});
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
      setState(() {});
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
      setState(() {});
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
    setState(() {});
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
                width: pWidth / 2.5,
                height: pWidth / 3.15,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: pWidth / 150,
              ),
              Column(
                children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'sf_pro',
                        color: Colors.white,
                        fontSize: pHeight / 50),
                  ),
                  SizedBox(
                    height: pWidth / 150,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget UIDiscount(String name, String imageUrl, String category, int priceOrg,
      int priceNew) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      child: InkWell(
        onTap: () {
          scaffoldState.currentState.showBottomSheet((context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter state) {
              return UIDetails(name, imageUrl, priceNew);
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'sf_pro',
                            color: Colors.white,
                            fontSize: pHeight / 50),
                      ),
                      Text(
                        "Rs. ${priceOrg.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'sf_pro',
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      Text(
                        "Rs. ${priceNew.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
//                            decoration: TextDecoration.lineThrough,
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
              height: pHeight / 3,
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

int flag = 0;

void populateSearchList2() {
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

  recentSearchList.clear();
  for (int i = 0; i < 5; i++) {
    recentSearchList.add(searchList[i]);
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
    populateSearchList2();
    for (int i = 0; i < searchList.length; i++) {
      if (searchList[i].name == itemSelectedName) {
        flag = 1;
        DailyNeeds d = DailyNeeds(
            searchList[i].imageUrl, searchList[i].name, searchList[i].price);

        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
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
                      searchList[i].name,
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
                        searchList[i].imageUrl,
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
                        "Price-${searchList[i].price.toString()}",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainHome(
                              key: const Key('__RIKEY1__'),
                              onReturnedFromCart: true,
                              itemToShow: searchList[i].name.toString(),
                              urlToShow: searchList[i].imageUrl.toString(),
                              priceToShow: searchList[i].price,
                            ),
                          ),
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
          ),
        );
      }
    }
    if (flag == 0) {
      return Text('Tumse na ho pai');
    }
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
