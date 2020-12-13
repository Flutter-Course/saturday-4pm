import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/screens/Auth_screen.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';
import 'package:my_shop/widgets/misc/image_frame.dart';

import 'collecting_data_title.dart';

class CollectingFirst extends StatefulWidget {
  final Function nextPage, showLogout;
  CollectingFirst(this.nextPage, this.showLogout);
  @override
  _CollectingFirstState createState() => _CollectingFirstState();
}

class _CollectingFirstState extends State<CollectingFirst> {
  File image;
  String userName, mobileNumber;
  FocusNode mobileNode;
  @override
  void initState() {
    super.initState();
    mobileNode = FocusNode();
  }

  void pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  bool validData() {
    return image != null &&
        userName != null &&
        userName.length >= 3 &&
        mobileNumber != null &&
        mobileNumber.length == 11 &&
        mobileNumber.startsWith('01');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              CollectingDataTitle(
                'Welcome,',
                'Few steps left to complete your profile.',
              ),
              SizedBox(
                height: 30,
              ),
              ImageFrame.fromFile(image),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                    onPressed: () {
                      pickImage(true);
                    },
                    color: Colors.black,
                    icon: Icon(
                      Icons.photo_library,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      pickImage(false);
                    },
                    color: Colors.black,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  mobileNode.requestFocus();
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'ex. Muhammed Aly',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    mobileNumber = value;
                  });
                },
                focusNode: mobileNode,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'ex. 01xxxxxxxxx',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          flex: 9,
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ArrowButton.left(
              child: 'Logout',
              onPressed: () async {
                if (await widget.showLogout()) {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                }
              },
            ),
            ArrowButton.right(
              child: 'Next',
              onPressed: () {
                //validation
                if (validData()) {
                  widget.nextPage(image, userName, mobileNumber);
                } else {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Invalid or missing data'),
                      content: Text(
                          'Please check that you have picked an image, entered at least 3 characters in the username and entered a valid mobile number.'),
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
                }
              },
            ),
          ],
        ))
      ],
    );
  }
}
