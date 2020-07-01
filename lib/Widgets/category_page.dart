import 'package:delivery/DrawerPages/MainHome.dart';
import 'package:delivery/Widgets/item.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  double pHeight, pWidth;
  List categories, discounts;
  Item item;
  State stateToRefresh;
  CategoryPage(this.pHeight, this.pWidth, this.categories, this.discounts,
      this.item, this.stateToRefresh);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: widget.pHeight / 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(
                      color: Color(0xFF345995),
                      fontSize: widget.pHeight / 21,
                      fontFamily: 'sf_pro',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: widget.pHeight / 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
                height: widget.pHeight / 7,
                child: widget.categories.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: widget.categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              widget.stateToRefresh.setState(() {
                                IndexSelected.indexSelected = index;
                                print(index);
                              });
                            },
                            child: UICat(
                                widget.categories[index].name,
                                widget.categories[index].imageUrl,
                                widget.pHeight,
                                widget.pWidth),
                          );
                        },
                      )),
          ),
          SizedBox(
            height: widget.pHeight / 35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              'Available Items',
              style: TextStyle(
                  color: Color(0xFF345995),
                  fontSize: widget.pHeight / 30,
                  fontFamily: 'sf_pro',
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: widget.pHeight / 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: widget.discounts.length == 0
                  ? widget.pHeight / 1.95
                  : widget.pHeight / 2.17,
              child: widget.item,
            ),
          )
        ],
      ),
    );
  }
}

Widget UICat(String name, String imageUrl, double pHeight, double pWidth) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.5),
    child: Container(
      height: pHeight / 7,
      decoration: BoxDecoration(
        color: Color(0xFF345995),
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: (pWidth - 100) / 3,
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
            width: (pWidth - 100) / 3,
            height: pHeight / 9.5,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: FittedBox(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'sf_pro',
                      color: Colors.white,
                      fontSize: pHeight / 55),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
