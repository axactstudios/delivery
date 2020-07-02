import 'package:delivery/DrawerPages/MainHome.dart';
import 'package:delivery/Widgets/ui_details.dart';
import 'package:flutter/material.dart';

class UI extends StatefulWidget {
  String name, imageUrl;
  int price;
  List cartList;
  State stateToRefresh;
  UI(this.name, this.imageUrl, this.price, this.cartList, this.stateToRefresh);
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      child: InkWell(
        onTap: () {
          scaffoldState.currentState.showBottomSheet((context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter state) {
              return UIDetails(
                name: widget.name,
                imageUrl: widget.imageUrl,
                price: widget.price,
                pHeight: pHeight,
                cartList: widget.cartList,
                stateToRefresh: widget.stateToRefresh,
              );
            });
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF345995),
            border: Border.all(color: Colors.black),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
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
                height: pWidth / 3.5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'sf_pro',
                              color: Colors.white,
                              fontSize: pHeight / 50),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          "Rs. ${widget.price.toString()}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'sf_pro',
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
