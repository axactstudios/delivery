import 'package:delivery/Classes/Orders.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../LoginPages/PhoneLogin.dart';

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
        //TODO: Change phone number
        if (DATA[key]['Status'] == 'notCompleted' ||
            DATA[key]['Status'] == 'Shipped') {
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Order date and time: ${DATA[key]['DateTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Order Total ${DATA[key]['TotalAmount']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: currListTile,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Text('Order Status is ${DATA[key]["Status"]}'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Shipping time: ${DATA[key]['ShippedTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Completion time: ${DATA[key]['CompletedTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Completed time: ${DATA[key]['CompletedTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
              ],
            ),
          );
          currOrdersCard.add(c);
        } else if (DATA[key]['Status'] == 'Completed') {
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Order date and time: ${DATA[key]['DateTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Order Total ${DATA[key]['TotalAmount']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: pastListTile,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Shipping time: ${DATA[key]['ShippedTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Completed time: ${DATA[key]['CompletedTime']}',
                    style: TextStyle(
                        color: Color(0xFF345995),
                        fontSize: 20,
                        fontFamily: 'sf_pro'),
                  ),
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
    print(" phone number is${widget.phno}");
    if (widget.phno != null) {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: currOrdersCard.length == 0
                            ? Center(child: Text("No orders"))
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: pastOrdersCard.length == 0
                            ? Center(child: Text("No orders"))
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
    } else {
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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Please Sign in to view your past orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF345995),
                    fontFamily: 'sf_pro',
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhoneLogin()));
                },
                child: Card(
                  color: Color(0xFF345995),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sf_pro'),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
}
