import 'package:flutter/material.dart';
import 'package:roovies/widgets/movies_list.dart';

class MoviesByGenre extends StatefulWidget {
  @override
  _MoviesByGenreState createState() => _MoviesByGenreState();
}

class _MoviesByGenreState extends State<MoviesByGenre>
    with TickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          bottom: TabBar(
            controller: controller,
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Action',
              ),
              Tab(
                text: 'Comedy',
              ),
              Tab(
                text: 'Tragedy',
              ),
              Tab(
                text: 'Sci-Fi',
              ),
              Tab(
                text: 'Horror',
              ),
              Tab(
                text: 'Romance',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
          ],
        ),
      ),
    );
  }
}
