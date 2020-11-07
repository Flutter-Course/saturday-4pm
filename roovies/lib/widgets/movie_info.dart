import 'package:flutter/material.dart';
import 'package:roovies/widgets/movie_info_item.dart';

class MovieInfo extends StatelessWidget {
  final int budget, duration;
  final String releaseDate;
  MovieInfo(this.budget, this.duration, this.releaseDate);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MovieInfoItem('Budget', budget.toString()),
          MovieInfoItem('Duration', duration.toString()),
          MovieInfoItem('Release Date', releaseDate),
        ],
      ),
    );
  }
}
