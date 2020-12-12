import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/Auth_screen.dart';
import 'package:my_shop/widgets/collecting_data_screen/Collecting_data_title.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_first.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';
import 'package:my_shop/widgets/misc/image_frame.dart';
import 'package:page_indicator/page_indicator.dart';

class CollectingData extends StatefulWidget {
  @override
  _CollectingDataState createState() => _CollectingDataState();
}

class _CollectingDataState extends State<CollectingData> {
  Future<bool> showLogout() async {
    return await showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
          'By logging out you will be asked the same questions in you next login.',
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (await showLogout()) {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }

        return false;
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: size.height - MediaQuery.of(context).padding.top,
                width: size.width,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: PageIndicatorContainer(
                  padding: EdgeInsets.only(bottom: 30),
                  length: 2,
                  indicatorColor: Colors.grey,
                  indicatorSelectorColor: Colors.black,
                  shape: IndicatorShape.roundRectangleShape(
                    size: Size(20, 5),
                    cornerSize: Size.square(20),
                  ),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: CollectingFirst(),
                            flex: 9,
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ArrowButton.left(
                                child: 'Logout',
                                onPressed: () async {
                                  if (await showLogout()) {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushReplacementNamed(
                                        AuthScreen.routeName);
                                  }
                                },
                              ),
                              ArrowButton.right(
                                child: 'Next',
                                onPressed: () {},
                              ),
                            ],
                          ))
                        ],
                      ),
                      Container(
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
