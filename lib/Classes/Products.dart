class DailyNeeds {
  String name, imageUrl;
  int price;
  DailyNeeds(this.imageUrl, this.name, this.price);
}

class OrderItem {
  String name;
  String price;
  OrderItem(this.name, this.price);
}

class Order {
  List<OrderItem> d = [];
  Order(this.d);
}
