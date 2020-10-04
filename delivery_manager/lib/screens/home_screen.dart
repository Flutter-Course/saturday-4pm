import 'package:delivery_manager/widgets/chart.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Text(
                      'Delivery Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chart(),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        OrderItem('Muhammed Aly', 50.0, '2:00PM'),
                        OrderItem('Toka Ehab', 100.0, '3:00PM'),
                        OrderItem('Ahmed Aly', 5000.0, '4:00PM'),
                        OrderItem('Muhammed Aly', 20.0, '5:00PM'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
