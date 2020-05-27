import 'package:delivery/Classes/Products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Cart extends StatefulWidget {
  final List<DailyNeeds> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  _CartState(this._cart);

  List<DailyNeeds> _cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            var item = _cart[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    child: ListTile(
                      leading: Image.network(item.imageUrl),
                      title: Row(children: <Widget>[
                        Text(item.name),
                        SizedBox(
                          width: 30,
                        ),
                        Text(item.price.toString())
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
                  Row(
                    children: <Widget>[
                      Text("Total Amount = Rs. ${totalAmount()}"),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                          onTap: openCheckout, child: Text("Proceed to pay"))
                    ],
                  )
                ],
              ),
            );
          }),
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
}
