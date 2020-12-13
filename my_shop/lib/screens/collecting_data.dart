import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_shop/providers/user_provider.dart';
import 'package:my_shop/screens/Auth_screen.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_first.dart';
import 'package:my_shop/widgets/collecting_data_screen/collecting_second.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class CollectingData extends StatefulWidget {
  @override
  _CollectingDataState createState() => _CollectingDataState();
}

class _CollectingDataState extends State<CollectingData> {
  PageController controller;
  File image;
  String userName, mobileNumber;
  int index;
  bool loading;

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
  void initState() {
    super.initState();
    index = 0;
    controller = PageController();
    loading = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void nextPage(File image, String userName, String mobileNumber) {
    setState(() {
      this.image = image;
      this.userName = userName;
      this.mobileNumber = mobileNumber;
      index++;
    });
    controller.nextPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void prevPage() {
    setState(() {
      index--;
    });
    controller.previousPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void submit(LatLng position, String address) async {
    setState(() {
      loading = true;
    });
    bool notError = await Provider.of<UserProvider>(context, listen: false)
        .completeUserProfile(image, userName, mobileNumber, address, position);

    if (!notError) {
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error has occurred'),
          content: Text('Please try again later.'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
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
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: (index == 1)
                      ? NeverScrollableScrollPhysics()
                      : ScrollPhysics(),
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
                        controller: controller,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CollectingFirst(nextPage, showLogout),
                          CollectingSecond(prevPage, submit),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (loading)
              Container(
                height: size.height,
                width: size.width,
                color: Colors.black38,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
