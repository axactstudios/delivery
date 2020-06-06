import 'package:delivery/Classes/Orders.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class YourOrders extends StatefulWidget {
  final String phno;

  const YourOrders({Key key, this.phno}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

int i = 0;

List<Container> currOrdersCard = [];
List<Container> pastOrdersCard = [];

String t;

class _YourOrdersState extends State<YourOrders> {
  void getOrderList() {
    String user = "+91${widget.phno}";
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

    );
  }
}
