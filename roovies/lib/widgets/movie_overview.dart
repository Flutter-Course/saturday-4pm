import 'package:flutter/material.dart';

class MovieOverView extends StatelessWidget {
  final String overview;
  MovieOverView(this.overview);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.blueGrey),
          ),
          Text(
            overview,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
