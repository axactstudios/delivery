import 'package:delivery/Widgets/item_ui.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  State stateToRefresh;
  List clothes, cartList;
  Item(this.cartList, this.clothes, this.stateToRefresh);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.clothes.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: widget.clothes.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return UI(
                    widget.clothes[index].name,
                    widget.clothes[index].imageUrl,
                    widget.clothes[index].price,
                    widget.cartList,
                    widget.stateToRefresh);
              },
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10.0),
            ),
    );
  }
}
