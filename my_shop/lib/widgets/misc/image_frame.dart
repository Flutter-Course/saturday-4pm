import 'dart:io';

import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final File imageFile;
  final String imageUrl;
  ImageFrame.fromFile(this.imageFile) : this.imageUrl = null;
  ImageFrame.fromNetwork(this.imageUrl) : this.imageFile = null;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 80.1,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 80,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 70 - 0.1,
            backgroundColor: Colors.grey,
            child: (imageFile == null && imageUrl == null)
                ? Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 40,
                  )
                : null,
            backgroundImage: (imageFile != null)
                ? FileImage(imageFile)
                : (imageUrl != null)
                    ? NetworkImage(imageUrl)
                    : null,
          ),
        ),
      ),
    );
  }
}
