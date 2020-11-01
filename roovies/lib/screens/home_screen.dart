import 'package:flutter/material.dart';
import 'package:roovies/widgets/movies_by_genre.dart';
import 'package:roovies/widgets/now_playing.dart';
import 'package:roovies/widgets/tending_persond.dart';
import 'package:roovies/widgets/trending_movies.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {},
        ),
        title: Text('Roovies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          MoviesByGenre(),
          TrendingPersons(),
          TrendingMovies(),
        ],
      ),
    );
  }
}
