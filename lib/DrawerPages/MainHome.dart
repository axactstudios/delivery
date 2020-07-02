import 'package:after_layout/after_layout.dart';
import 'package:delivery/Classes/categories.dart';
import 'package:delivery/Classes/Products.dart';
import 'package:delivery/Classes/dicounts.dart';

import 'package:delivery/Providers/all_database_ref.dart';
import 'package:delivery/UserModel.dart';
import 'package:delivery/Widgets/category_page.dart';
import 'package:delivery/Widgets/drawer_widgets.dart';
import 'package:delivery/Widgets/item.dart';
import 'package:delivery/Widgets/ui_details.dart';
import 'package:delivery/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Cart/Cart.dart';

class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');
  static final riKey3 = const Key('__RIKEY3__');
  static final riKey4 = const Key('__RIKEY4__');
  static final riKey5 = const Key('__RIKEY5__');
  static final riKey6 = const Key('__RIKEY6__');
  static final riKey7 = const Key('__RIKEY7__');
  static final riKey8 = const Key('__RIKEY8__');
  static final riKey9 = const Key('__RIKEY9__');
}

class IndexSelected {
  static int indexSelected;
}

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
List<DailyNeeds> _cartList = [];

class _MainHomeState extends State<MainHome> with AfterLayoutMixin<MainHome> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseUser _user;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Categories> categories = [];
  List<Discounts> discounts = [];
  List<DailyNeeds> dailyneeds = [];
  List<DailyNeeds> clothes = [];
  List<DailyNeeds> staples = [];
  List<DailyNeeds> beverages = [];
  List<DailyNeeds> personalCare = [];
  List<DailyNeeds> snacks = [];
  List<DailyNeeds> freshFruits = [];
  List<DailyNeeds> homeCare = [];
  List<DailyNeeds> dairy = [];

  @override
  void initState() {
    super.initState();
    IndexSelected.indexSelected = 1;
    print(IndexSelected.indexSelected);
    getUserDetails(); //Added this function to get the user details as soon as screen is opened.
    getCategoriesRef(this, categories);
    getDailyNeedItemRef(this, dailyneeds);
    getClothesRef(this, clothes);
    getStaplesItemsRef(this, staples);
    getBeveragesItemsRef(this, beverages);
    getPersonalCareItemsRef(this, personalCare);
    getSnacksIsRef(this, snacks);
    getFreshFruitsItemsRef(this, freshFruits);
    getHomeCareItemsRef(this, homeCare);
    getDairyItemsRef(this, dairy);
    discountref(this, discounts);
  }

//Just changing
  FirebaseUser user1;
  String name;

  User userData = new User(); //Object of the user model class

  void getUserDetails() async {
    FirebaseUser user = await mAuth.currentUser();
    _user = user;

    DatabaseReference userref = await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user.uid); //Retrieving the record using UID of the user
    userref.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      userData.name = DATA['Name'];
      userData.number = DATA['Number'];
      userData.addressLine1 = DATA['Addressline1'];
      userData.addressLine2 = DATA['Addressline2'];
      userData.pinCode = DATA['pincode'];
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
            name: widget.itemToShow,
            imageUrl: widget.urlToShow,
            price: widget.priceToShow,
            pHeight: pHeight,
            cartList: _cartList,
            stateToRefresh: this,
          );
        });
      });
    }
  }

  List categoryToShow = new List();
  @override
  Widget build(BuildContext context) {
    if (IndexSelected.indexSelected == 0)
      categoryToShow = staples;
    else if (IndexSelected.indexSelected == 1)
      categoryToShow = dailyneeds;
    else if (IndexSelected.indexSelected == 2)
      categoryToShow = beverages;
    else if (IndexSelected.indexSelected == 3)
      categoryToShow = clothes;
    else if (IndexSelected.indexSelected == 4)
      categoryToShow = personalCare;
    else if (IndexSelected.indexSelected == 5)
      categoryToShow = snacks;
    else if (IndexSelected.indexSelected == 6)
      categoryToShow = freshFruits;
    else if (IndexSelected.indexSelected == 7)
      categoryToShow = homeCare;
    else if (IndexSelected.indexSelected == 8)
      categoryToShow = dairy;
    else
      categoryToShow = staples;

    print(IndexSelected.indexSelected);
    //Header for user information
    //Nav Drawer items
    final drawerItems = getDrawerItems(userData, context);
    pWidth = MediaQuery.of(context).size.width;
    pHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldState,
      appBar: CustomAppBar(
        key: RIKeys.riKey2,
        cartList: _cartList,
        userPhno: userData.number,
        stateToRefresh: this,
      ),
      drawer: Drawer(
        key: _drawerKey,
        child: drawerItems,
      ),
      body: CategoryPage(pHeight, pWidth, categories, discounts,
          Item(_cartList, categoryToShow, this), this, _cartList),
    );
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
}
