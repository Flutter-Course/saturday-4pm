import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/widgets/genres_list.dart';
import 'package:roovies/widgets/movie_info.dart';
import 'package:roovies/widgets/movie_overview.dart';
import 'package:roovies/widgets/movie_rating_bar.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool firstRun, successful;
  MovieDetails movieDetails;
  Movie movie;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      movie = ModalRoute.of(context).settings.arguments as Movie;
      MovieDetails tmp =
          await Provider.of<MoviesProvider>(context, listen: false)
              .fetchMovieDetailsById(movie.id);

      setState(() {
        if (tmp != null) {
          successful = true;
          movieDetails = tmp;
        } else {
          successful = false;
        }
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (successful)
              ? SliverFab(
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  floatingPosition: FloatingPosition(right: 15),
                  floatingWidget: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.play_arrow,
                    ),
                  ),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Container(
                          margin: EdgeInsets.only(right: 75),
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        background: Stack(
                          children: [
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image.network(
                                movie.backPosterUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            MovieRatingBar(movie.rating),
                            MovieOverView(movieDetails.overview),
                            MovieInfo(
                              movieDetails.budget,
                              movieDetails.duration,
                              movieDetails.releaseDate,
                            ),
                            GenresList(movieDetails.genres),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'Error has occurred',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
    );
  }
}
