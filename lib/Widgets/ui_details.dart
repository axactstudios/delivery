import 'package:delivery/Classes/Products.dart';
import 'package:flutter/material.dart';

class UIDetails extends StatefulWidget {
  String name, imageUrl;
  int price;
  double pHeight;
  List cartList;
  State stateToRefresh;
  UIDetails(
      {this.name,
      this.imageUrl,
      this.price,
      this.pHeight,
      this.cartList,
      this.stateToRefresh});
  @override
  _UIDetailsState createState() => _UIDetailsState();
}

class _UIDetailsState extends State<UIDetails> {
  @override
  Widget build(BuildContext context) {
    DailyNeeds d = DailyNeeds(widget.imageUrl, widget.name, widget.price);

    return Container(
      height: widget.pHeight,
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
              height: widget.pHeight / 30,
            ),
            Container(
              color: Color(0xFF345995),
              child: Text(
                d.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.pHeight / 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'sf_pro',
                ),
              ),
            ),
            SizedBox(
              height: widget.pHeight / 30,
            ),
            Container(
              height: widget.pHeight / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.network(
                  d.imageUrl,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(
              height: widget.pHeight / 30,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Price-${d.price.toString()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.pHeight / 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
            ),
            Container(
              height: widget.pHeight / 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Description-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.pHeight / 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sf_pro',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.pHeight / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.stateToRefresh.setState(
                    () {
                      widget.cartList.add(d);
                    },
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
    );
  }
}
