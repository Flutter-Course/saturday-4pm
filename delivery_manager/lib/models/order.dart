import 'package:flutter/foundation.dart';

class Order {
  int id;
  String deliveryMan;
  double price;
  DateTime orderDate;
  static int _count = 0;
  Order({
    @required this.deliveryMan,
    @required this.orderDate,
    @required this.price,
  }) {
    this.id = ++_count;
  }
}
