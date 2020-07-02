import 'package:delivery/Widgets/item_ui.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  State stateToRefresh;
  List itemCategory, cartList;
  Item(this.cartList, this.itemCategory, this.stateToRefresh);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.itemCategory.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: widget.itemCategory.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return UI(
                    widget.itemCategory[index].name,
                    widget.itemCategory[index].imageUrl,
                    widget.itemCategory[index].price,
                    widget.cartList,
                    widget.stateToRefresh);
              },
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10.0),
            ),
    );
  }
}
