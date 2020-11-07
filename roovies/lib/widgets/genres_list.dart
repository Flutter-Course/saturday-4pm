import 'package:flutter/material.dart';
import 'package:roovies/models/genre.dart';
import 'package:roovies/widgets/genre_item.dart';

class GenresList extends StatelessWidget {
  final List<Genre> genres;
  GenresList(this.genres);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genres',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.blueGrey),
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: genres.map((e) {
              return GenreItem(e.name);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
