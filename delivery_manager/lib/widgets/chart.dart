import 'dart:collection';

import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/chart_bar.dart';
import 'package:delivery_manager/widgets/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final DateTime selectedDate;
  final Function changeSelectedDate;
  final SplayTreeSet<Order> selectedOrders;
  Chart(this.selectedDate, this.changeSelectedDate, this.selectedOrders);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Map<String, int> count;

  void filter() {
    count = Map<String, int>();
    if (widget.selectedOrders != null) {
      widget.selectedOrders.forEach((element) {
        if (count.containsKey(element.deliveryMan)) {
          count[element.deliveryMan]++;
        } else {
          count[element.deliveryMan] = 1;
        }
      });
    }
  }

  double calculateHeight(int ordersCount, BoxConstraints constraints) {
    return ordersCount * constraints.maxHeight / 20;
  }

  @override
  Widget build(BuildContext context) {
    filter();
    return Card(
      elevation: 5,
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ).add(EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.03,
      )),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  DateTime currentDate = DateTime.now().subtract(
                    Duration(days: index),
                  );
                  String date = DateFormat('dd/MM').format(currentDate);
                  bool selected =
                      DateFormat('dd/MM/yyyy').format(widget.selectedDate) ==
                          DateFormat('dd/MM/yyyy').format(currentDate);
                  return Container(
                    margin: EdgeInsets.only(
                        left: index != 6 ? 2 : 0, right: index != 0 ? 2 : 0),
                    child: FlatButton(
                      shape: StadiumBorder(),
                      color: selected ? Colors.amber : Colors.amber[100],
                      child: Text(date),
                      onPressed: () {
                        widget.changeSelectedDate(currentDate);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: widget.selectedOrders != null &&
                      widget.selectedOrders.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text('#Orders'),
                              Expanded(child: Container()),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    HeroItem(Colors.blue, 'Muhammed Aly'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    HeroItem(Colors.yellow, 'Toka Ehab'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    HeroItem(Colors.purple, 'Ahmed Aly'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    height: constraints.maxHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    width: constraints.maxWidth * 0.1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('20'),
                                        Text('10'),
                                        Text('0'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.9,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (count.containsKey('Muhammed Aly'))
                                          ChartBar(
                                            height: calculateHeight(
                                                count['Muhammed Aly'],
                                                constraints),
                                            color: Colors.blue,
                                            name: 'Muhammed Aly',
                                            numberOfOrders:
                                                count['Muhammed Aly'],
                                          ),
                                        if (count.containsKey('Toka Ehab'))
                                          ChartBar(
                                            height: calculateHeight(
                                                count['Toka Ehab'],
                                                constraints),
                                            color: Colors.yellow,
                                            name: 'Toka Ehab',
                                            numberOfOrders: count['Toka Ehab'],
                                          ),
                                        if (count.containsKey('Ahmed Aly'))
                                          ChartBar(
                                            height: calculateHeight(
                                                count['Ahmed Aly'],
                                                constraints),
                                            color: Colors.purple,
                                            name: 'Ahmed Aly',
                                            numberOfOrders: count['Ahmed Aly'],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text('No Orders'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
