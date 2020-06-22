import 'package:delivery/Classes/Products.dart';
import 'package:delivery/DrawerPages/MainHome.dart';
import 'package:delivery/DrawerPages/your_account_page.dart';
import 'package:delivery/LoginPages/PhoneLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../UserModel.dart';

class Cart extends StatefulWidget {
  final List<DailyNeeds> _cart;
  String userPhNo;
  String userAddress;

  Cart(this._cart, this.userPhNo);

  @override
  _CartState createState() => _CartState(this._cart);
}

void showToast(message, Color color) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Color(0xFF345995),
    fontSize: 16.0,
  );
}

class _CartState extends State<Cart> {
//  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  _CartState(this._cart);

  List<DailyNeeds> _cart;
  double pHeight, pWidth;

  User userData = new User();
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void getUserDetails() async {
    FirebaseUser user = await mAuth.currentUser();

    DatabaseReference userref = await FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(user.uid);
    userref.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      userData.name = DATA['Name'];
      userData.addressLine1 = DATA['Addressline1'];
      userData.addressLine2 = DATA['Addressline2'];
      userData.number = DATA['Number'];
      userData.pinCode = DATA['pincode'];
    });
  }

  @override
  Widget build(BuildContext context) {
    pHeight = MediaQuery.of(context).size.height;
    pWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Color(0xFF345995),
        ),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Cart',
                  style: TextStyle(
                      color: Color(0xFF345995),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'sf_pro',
                      fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  var item = _cart[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Card(
                      color: Color(0xFF345995),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Image.network(
                            item.imageUrl,
                            height: pHeight / 15,
                          ),
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  item.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontWeight: FontWeight.bold,
                                      fontSize: pHeight / 45),
                                ),
                                Text(
                                  item.price.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontSize: pHeight / 55),
                                )
                              ]),
                          trailing: GestureDetector(
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onTap: () {
                                setState(() {
                                  _cart.remove(item);
                                });
                              }),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            height: pHeight / 4,
            decoration: BoxDecoration(
              color: Color(0xFF345995),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Order Total = Rs. ${totalAmount() + 0.18 * totalAmount() + 40}  ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sf_pro',
                                fontSize: pHeight / 40),
                          ),
                          Text(
                            "Products Total = Rs. ${totalAmount()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sf_pro',
                                fontSize: pHeight / 60),
                          ),
                          Text(
                            "GST(18%) = Rs. ${(totalAmount() * 0.18).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sf_pro',
                                fontSize: pHeight / 60),
                          ),
                          Text(
                            "Delivery Charges = Rs. 40.0",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sf_pro',
                                fontSize: pHeight / 60),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _showCODDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Proceed for COD",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'sf_pro',
                                      fontSize: pHeight / 45,
                                      color: Color(0xFF345995)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: pHeight / 70,
                          ),
                          InkWell(
                            onTap: () {
                              _showPayOnlineDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Pay online",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'sf_pro',
                                      fontSize: pHeight / 45,
                                      color: Color(0xFF345995)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: pHeight / 80,
                  ),
                  InkWell(
                    onTap: () {
                      if (mAuth.currentUser() != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YourAccount(
                                      phno: userData.number,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneLogin()));
                      }
                    },
                    child: Container(
                      width: pWidth - 20,
                      height: pHeight / 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            "Check address details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'sf_pro',
                                fontSize: pHeight / 60,
                                color: Color(0xFF345995)),
                          ),
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
    );
  }

  Widget _showCODDialog() {
    if (mAuth.currentUser() != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Place order?"),
              content: Text("The order will be placed"),
              actions: [
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    saveOrder(totalAmount() + 0.18 * totalAmount() + 40);
                  },
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login"),
              content: Text("To place order you must be logged in."),
              actions: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Login"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneLogin()));
                  },
                )
              ],
            );
          });
    }
  }

  Widget _showPayOnlineDialog() {
    if (mAuth.currentUser() != null) {
      openCheckout();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login"),
              content: Text("To place order you must be logged in."),
              actions: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Login"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneLogin()));
                  },
                )
              ],
            );
          });
    }
  }

  double totalAmount() {
    double amount = 0;
    for (int i = 0; i < _cart.length; i++) {
      amount += _cart[i].price;
    }

    return amount;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_uqORQiidCVwzWI',
      'amount': ((totalAmount() + 0.18 * totalAmount() + 40) * 100).toString(),
      'name': 'Axact Studios',
      'description': 'Bill',
      'prefill': {'contact': '', '': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    saveOrder(totalAmount() + 0.18 * totalAmount() + 40);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    setState(() {
//      _cart.clear();
      //TODO Clear cart function debug orders not saving if cart is cleared.
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  void saveOrder(double amount) async {
    FirebaseUser user = await mAuth.currentUser();

    DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child("Orders")
        .child(user.uid)
        .push();

    dbRef.set({
      "Status": "notCompleted",
      "orderLength": _cart.length,
      "DateTime": DateTime.now().toString(),
      "TotalAmount": amount.toString(),
      "ShippedTime": "Not Yet Shipped",
      "CompletedTime": "Not Yet completed"
    });
    for (int i = 0; i < _cart.length; i++) {
      dbRef.child(i.toString()).set({
        "Name": _cart[i].name,
        "Price": _cart[i].price.toString(),
      }).then((_) {
        showToast("Successfully ordered", Colors.white);
      }).catchError((onError) {
        showToast(onError, Colors.white);
      });
    }
  }
}
