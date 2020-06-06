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
    DatabaseReference dailyitemsref = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .child("+91${widget.phno}");
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
              subtitle: Text('${DATA[key][i.toString()]['Price']}'),
              title: Text('${DATA[key][i.toString()]['Name']}'),
            );
            currListTile.add(t1);
          }
          Container c = new Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border()),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: currListTile,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text('Order Status is ${DATA[key]["Status"]}'),
                ),
              ],
            ),
          );
          currOrdersCard.add(c);
        } else {
          print('Order Length is ${DATA[key]['orderLength'].toString()}');
          for (i = 0; i < DATA[key]['orderLength']; i++) {
            ListTile t1 = new ListTile(
              subtitle: Text('${DATA[key][i.toString()]['Price']}'),
              title: Text('${DATA[key][i.toString()]['Name']}'),
            );
            pastListTile.add(t1);
          }
          Container c = new Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border()),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: pastListTile,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text('Order Status is ${DATA[key]["Status"]}'),
                ),
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
          'Your Orders',
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
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text(
                    'Current Orders',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF345995),
                        fontSize: 24,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      padding: EdgeInsets.only(top: 7.5),
                      decoration: BoxDecoration(
                          color: Color(0xFF345995),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: currOrdersCard.length == 0
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: currOrdersCard.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, index) {
                                return currOrdersCard[index];
                              },
                            )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text(
                    'Past Orders',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF345995),
                        fontSize: 24,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      padding: EdgeInsets.only(top: 7.5),
                      decoration: BoxDecoration(
                          color: Color(0xFF345995),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: pastOrdersCard.length == 0
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: pastOrdersCard.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, index) {
                                return pastOrdersCard[index];
                              },
                            )),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
