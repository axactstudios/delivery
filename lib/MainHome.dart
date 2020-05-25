import 'package:delivery/categories.dart';
import 'package:delivery/dailyneeds.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

double pWidth, pHeight;
var indexSelected = 1;

class _MainHomeState extends State<MainHome> {
  List<Categories> categories = [];
  List<DailyNeeds> dailyneeds = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference dailyitemsref = FirebaseDatabase.instance
        .reference()
        .child('Grocery')
        .child('Daily needs');
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
  }

  @override
  Widget build(BuildContext context) {
    pWidth = MediaQuery.of(context).size.width;
    pHeight = MediaQuery.of(context).size.height;
    if (indexSelected == 1) {
      return retDailyNeedsPage();
    } else {
      return retClothesPage();
    }
  }

  Widget retDailyNeeds() {
    return Container(
      height: 500.0,
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

  Widget retClothesPage() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('ClothesPage'),
              InkWell(
                onTap: () {
                  setState(() {
                    indexSelected = 1;
                    print(indexSelected.toString());
                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.teal,
                  child: Text(
                    'Go Back to DailyNeeds Page',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
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
