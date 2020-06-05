import 'package:delivery/Classes/Orders.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class YourOrders extends StatefulWidget {
  @override
  _YourOrdersState createState() => _YourOrdersState();
}

int i = 0;

List<Container> currOrdersCard = [];
List<Container> pastOrdersCard = [];

String t;

class _YourOrdersState extends State<YourOrders> {
  void getOrderList() {
    DatabaseReference dailyitemsref = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .child("+917060222315");
    dailyitemsref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      pastOrdersCard.clear();
      currOrdersCard.clear();
      for (var key in KEYS) {
        List<ListTile> currListTile = [];
        List<ListTile> pastListTile = [];

        currListTile.clear();
        pastListTile.clear();
        int l = 0;
        //TODO: Change phone number
        if (DATA[key]['Status'] == 'notCompleted') {
          print('Order Length is ${DATA[key]['orderLength'].toString()}');
          for (i = 0; i < DATA[key]['orderLength']; i++) {
            ListTile t1 = new ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(
                  '${DATA[key][i.toString()]['Name']},${DATA[key][i.toString()]['Price']},'),
            );
            currListTile.add(t1);
          }
          Container c = new Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border()),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: currListTile,
                ),
                Text('Order Status is ${DATA[key]["Status"]}'),
              ],
            ),
          );
          currOrdersCard.add(c);
        } else {
          print('Order Length is ${DATA[key]['orderLength'].toString()}');
          for (i = 0; i < DATA[key]['orderLength']; i++) {
            ListTile t1 = new ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(
                  '${DATA[key][i.toString()]['Name']},${DATA[key][i.toString()]['Price']},'),
            );
            pastListTile.add(t1);
          }
          Container c = new Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border()),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: pastListTile,
                ),
                Text('Order Status is ${DATA[key]["Status"]}'),
              ],
            ),
          );
          pastOrdersCard.add(c);
        }
      }
    });
  }

  Order createOrder(List<OrderItem> d) {
    Order temp = new Order(d);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
//    -M9-0YpNwG_oJFAi3FHH
    getOrderList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Past Orders',
          style: TextStyle(color: Color(0xFF345995)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF345995),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
//        body: Column(
//          children: [
////            Text(pastOrders[0].d.length.toString()),
//            Text(currOrders.length.toString()),
////            Text(pastOrders.length.toString()),
//            Text(currOrders[0].d.length.toString()),
//            Text(currOrders[1].d.length.toString()),
//            Text(currOrders[2].d.length.toString()),
//            Text(currOrders[0].d[0].price.toString()),
//            Text(currOrders[0].d[0].name.toString()),
//
//          ],
//        )
      body: Column(
        children: <Widget>[
          Text('Current Orders'),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: currOrdersCard,
          ),
          Text('Past Orders'),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: pastOrdersCard,
          )
        ],
      ),
//        body: currOrders.isEmpty
//            ? pastOrders.isEmpty
//                ?
//                //When both the orders list are empty
//                Container(
//                    color: Colors.white,
//                    child: Center(
//                        child: Text('Your past orders will be displayed')),
//                  )
//                :
//                //Current orders are empty but we have past pastOrders
//                Column(
//                    children: <Widget>[
//                      Text('Past Orders'),
////                      Text(pastOrders[0].d[0].name),
////                      Text(pastOrders[0].d[0].price),
//                    ],
//                  )
//            : pastOrders.isEmpty
//                ?
//                //We have only current orders
//                Column(
//                    children: <Widget>[
//                      Text('Current Orders'),
//                      Text(currOrders[0].d.length.toString()),
//                      Text(currOrders[0].d[0].price),
//                      Text(currOrders[0].d[1].price),
//                    ],
//                  )
//                :
//                //We have both current and past orders
//                Column(
//                    children: <Widget>[
//                      Text('Current Orders'),
//                      Text(currOrders.length.toString()),
//                      Text(currOrders[0].d.length.toString()),
//                      Text('Past Orders'),
//                      Text(pastOrders.length.toString()),
////
//                      Text(pastOrders[0].d.length.toString()),
////                      Text(pastOrders[0].d[0].price.toString()),
//                    ],
    );
  }
}
