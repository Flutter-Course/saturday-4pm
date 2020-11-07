import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  final String genre;
  GenreItem(this.genre);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        genre,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
