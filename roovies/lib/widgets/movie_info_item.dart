import 'package:flutter/material.dart';

class MovieInfoItem extends StatelessWidget {
  final String title, value;
  MovieInfoItem(this.title, this.value);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        )
      ],
    );
  }
}
