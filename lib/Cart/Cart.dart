import 'package:delivery/Classes/Products.dart';
import 'package:delivery/DrawerPages/MainHome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Cart extends StatefulWidget {
  final List<DailyNeeds> _cart;
  String userPhNo;
  String userAddress;

  Cart(this._cart, this.userPhNo);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
//  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  _CartState(this._cart);

  List<DailyNeeds> _cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                            height: 200,
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
                                      fontSize: 20),
                                ),
                                Text(
                                  item.price.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontSize: 16),
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
            height: pHeight / 10,
            decoration: BoxDecoration(
              color: Color(0xFF345995),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Total Amount = Rs. ${totalAmount()}",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'sf_pro', fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    openCheckout();
                    saveOrder();
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
                        "Proceed to pay",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sf_pro',
                            fontSize: pHeight / 45,
                            color: Color(0xFF345995)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  int totalAmount() {
    int amount = 0;
    for (int i = 0; i < _cart.length; i++) {
      amount += _cart[i].price;
    }
    return amount;
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_uqORQiidCVwzWI',
      'amount': (totalAmount() * 100).toString(),
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
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    //storing order details in database

//    for (int i = 0; i < _cart.length; i++) {
//      DatabaseReference userRef =
//          FirebaseDatabase.instance.reference().child('Orders');
//      userRef.set({i: _cart[i]}).whenComplete(
//          () => print('Successfully stored order'));
//    }
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

  void saveOrder() {
    String user =
        widget.userPhNo == null ? '+917060222315' : "+91${widget.userPhNo}";

    //Registering new order
    DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child("Orders")
        .child("+917060222315")
        .push();

    dbRef.set({
//      "UserPhNo": widget.userPhNo == null ? "+917060222315" : widget.userPhNo,
      "Status": "notCompleted",
      "orderLength": _cart.length
    });
    for (int i = 0; i < _cart.length; i++) {
      dbRef.child(i.toString()).set({
        "Name": _cart[i].name,
        "Price": _cart[i].price.toString(),
      }).then((_) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Successfully Added')));
      }).catchError((onError) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
      });
    }
  }
}
