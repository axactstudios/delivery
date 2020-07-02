import 'package:delivery/Classes/Products.dart';
import 'package:delivery/Classes/categories.dart';
import 'package:delivery/Classes/dicounts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void getCategoriesRef(State stateToRefresh, List categories) {
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
    stateToRefresh.setState(() {});
  });
}

void getClothesRef(State stateToRefresh, List clothes) {
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
    stateToRefresh.setState(() {});
  });
}

void discountref(State stateToRefresh, List discounts) {
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
    stateToRefresh.setState(() {
      print('No of discounts are ${discounts.length}');
    });
  });
}

void getDailyNeedItemRef(State stateToRefresh, List dailyneeds) {
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
    stateToRefresh.setState(() {});
  });
}

void getStaplesItemsRef(State stateToRefresh, List staples) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Staples');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    staples.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      staples.add(d);
    }
    stateToRefresh.setState(() {});
  });
}

void getBeveragesItemsRef(State stateToRefresh, List beverages) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Beverages');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    beverages.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      beverages.add(d);
    }
    stateToRefresh.setState(() {});
  });
}

void getPersonalCareItemsRef(State stateToRefresh, List personalCare) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Personal Care');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    personalCare.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      personalCare.add(d);
    }
    stateToRefresh.setState(() {});
  });
}

void getSnacksIsRef(State stateToRefresh, List snacks) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Snacks & Branded Food');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    snacks.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      snacks.add(d);
    }
    stateToRefresh.setState(() {});
  });
}

void getFreshFruitsItemsRef(State stateToRefresh, List freshFruits) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Fruits & Vegetables');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    freshFruits.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      freshFruits.add(d);
    }
    stateToRefresh.setState(() {});
  });
}

void getHomeCareItemsRef(State stateToRefresh, List homecare) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Home Care');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    homecare.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      homecare.add(d);
    }
    stateToRefresh.setState(() {});
  });
}

void getDairyItemsRef(State stateToRefresh, List dairy) {
  DatabaseReference dailyitemsref =
      FirebaseDatabase.instance.reference().child('Dairy & Bakery');
  dailyitemsref.once().then((DataSnapshot snap) {
    // ignore: non_constant_identifier_names
    var KEYS = snap.value.keys;
    // ignore: non_constant_identifier_names
    var DATA = snap.value;
    dairy.clear();
    for (var key in KEYS) {
      DailyNeeds d = new DailyNeeds(
          DATA[key]['ImageUrl'], DATA[key]['Name'], DATA[key]['Price']);
      dairy.add(d);
    }
    stateToRefresh.setState(() {});
  });
}
