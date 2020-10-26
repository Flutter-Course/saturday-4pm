import 'dart:collection';
import 'dart:math';

import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/add_order_sheet.dart';
import 'package:delivery_manager/widgets/background_container.dart';
import 'package:delivery_manager/widgets/chart.dart';
import 'package:delivery_manager/widgets/homescreen_title.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:delivery_manager/widgets/sticky_header_head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  HomeScreen(this.toggleTheme);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  bool showUpButton = false;
  List<String> deliveryMen = ['Muhammed Aly', 'Toka Ehab', 'Ahmed Aly'];
  SplayTreeMap<String, Map<String, dynamic>> orders =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });
  DateTime selectedDate;
  SplayTreeSet<Order> selectedOrders;
  bool isDark;
  @override
  void initState() {
    super.initState();
    isDark = false;
    selectedDate = DateTime.now();
    final ordersList = List.generate(12, (index) {
      return Order(
        deliveryMan: deliveryMen[Random().nextInt(3)],
        price: Random().nextDouble() * 500,
        orderDate: DateTime.now().subtract(
          Duration(
            days: Random().nextInt(12),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        ),
      );
    });

    ordersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderDate);
      if (!orders.containsKey(key)) {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(element.orderDate);
        orders[key]['list'] = SplayTreeSet((Order a, Order b) {
          return -a.orderDate.compareTo(b.orderDate);
        });
      }
      orders[key]['list'].add(element);
    });

    String key = DateFormat('yyyyMMdd').format(selectedDate);
    if (orders.containsKey(key)) {
      selectedOrders = orders[key]['list'];
    } else {
      selectedOrders = null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addOrder(String key, Order order) {
    setState(() {
      Navigator.of(context).pop();
      if (orders.containsKey(key)) {
        orders[key]['list'].add(order);
      } else {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(order.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>((Order a, Order b) {
          return -a.orderDate.compareTo(b.orderDate);
        });
        orders[key]['list'].add(order);
      }
    });
  }

  void removeOrder(String key, Order order) {
    setState(() {
      (orders[key]['list'] as SplayTreeSet<Order>).remove(order);
      if (orders[key]['list'].isEmpty) {
        orders.remove(key);
      }
    });
  }

  void changeSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      String key = DateFormat('yyyyMMdd').format(selectedDate);
      if (orders.containsKey(key)) {
        selectedOrders = orders[key]['list'];
      } else {
        selectedOrders = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          BackgroundContainer(),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  HomeScreenTitle(),
                  Chart(selectedDate, changeSelectedDate, selectedOrders),
                  Expanded(
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels > 40 &&
                            showUpButton == false) {
                          setState(() {
                            showUpButton = true;
                          });
                        } else if (notification.metrics.pixels <= 40 &&
                            showUpButton == true) {
                          setState(() {
                            showUpButton = false;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: controller,
                        padding: EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 56,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          List<String> keys = orders.keys.toList();
                          String key = keys[index];
                          String date = orders[key]['date'];
                          SplayTreeSet<Order> list = orders[key]['list'];
                          return StickyHeader(
                            header: StickyHeaderHead(date),
                            content: Column(
                              children: list.map((element) {
                                return OrderItem(element, removeOrder);
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 2 * kFloatingActionButtonMargin),
        child: Row(
          mainAxisAlignment: (showUpButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showUpButton)
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.jumpTo(0.0);
                },
              ),
            Spacer(),
            Switch.adaptive(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
                widget.toggleTheme();
              },
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return AddOrderSheet(deliveryMen, addOrder);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
