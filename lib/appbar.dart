import 'package:delivery/Cart/Cart.dart';
import 'package:delivery/Classes/Products.dart';
import 'package:delivery/DrawerPages/MainHome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  List cartList;
  String userPhno;
  State stateToRefresh;
  CustomAppBar({Key key, this.cartList, this.userPhno, this.stateToRefresh})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                  builder: (context) => Cart(
                      widget.cartList,
                      widget.userPhno,
                      widget
                          .stateToRefresh), //Replaced widget.phno with userData.number
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
                if (widget.cartList.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        widget.cartList.length.toString(),
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
