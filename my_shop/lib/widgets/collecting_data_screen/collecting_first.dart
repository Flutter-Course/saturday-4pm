import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/widgets/misc/image_frame.dart';

import 'Collecting_data_title.dart';

class CollectingFirst extends StatefulWidget {
  @override
  _CollectingFirstState createState() => _CollectingFirstState();
}

class _CollectingFirstState extends State<CollectingFirst> {
  File image;
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
