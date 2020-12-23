import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File> images;
  String category, gender, title, description, age;
  double price;
  @override
  void initState() {
    super.initState();
    images = [];
  }

  Future<int> cameraOrGallery() async {
    return await showDialog(
      context: context,
      child: SimpleDialog(
        title: Text('Image Source'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(1);
            },
            child: Row(
              children: [
                Icon(Icons.camera),
                SizedBox(
                  width: 5,
                ),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(2);
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(
                  width: 5,
                ),
                Text('Gallery'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(-1);
            },
            child: Row(
              children: [
                Icon(Icons.cancel),
                SizedBox(
                  width: 5,
                ),
                Text('Cancel'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getImage() async {
    int choice = await cameraOrGallery();
    ImagePicker picker = ImagePicker();
    if (choice != -1) {
      final pickedFile = await picker.getImage(
          source: choice == 1 ? ImageSource.camera : ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          images.add(File(pickedFile.path));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick product photos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Pick good photos so your product can attract the user.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 5),
                scrollDirection: Axis.horizontal,
                itemExtent: MediaQuery.of(context).size.width * 0.4,
                itemCount: images.length + ((images.length < 5) ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == 0 && images.length < 5) {
                    return InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Card(
                        color: Colors.grey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.only(right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Add Image',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    int i = index - ((images.length < 5) ? 1 : 0);
                    return Stack(
                      children: [
                        Card(
                          color: Colors.grey,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.only(
                              left: index == 0 ? 0 : 5,
                              right: index == 4 ? 0 : 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(images[i]),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                images.removeAt(i);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                gradient: RadialGradient(colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0),
                                ]),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
