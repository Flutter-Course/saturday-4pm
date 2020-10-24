import 'package:delivery_manager/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final Function removeOrder;
  OrderItem(this.order, this.removeOrder);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).accentColor == Colors.grey[600];
    return Card(
      elevation: 5,
      color: isDark
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ).add(
        EdgeInsets.only(bottom: 12),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                !isDark ? Theme.of(context).primaryColor : Colors.black,
            radius: 30,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${order.price.toStringAsFixed(2)}\$',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            order.deliveryMan,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Text(
            DateFormat('hh:mm a').format(order.orderDate),
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              removeOrder(
                  DateFormat('yyyyMMdd').format(order.orderDate), order);
            },
          ),
        ),
      ),
    );
  }
}
