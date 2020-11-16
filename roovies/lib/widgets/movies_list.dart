import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/dummy_data.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/screens/movie_details_screen.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenre(this.genreId);
  MoviesList.byTrending() : this.genreId = null;
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool firstRun, successful;
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
      bool done;
      if (widget.genreId != null) {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchMoviesByGenreId(widget.genreId);
      } else {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchTrendingMovies();
      }
      if (mounted) {
        setState(() {
          successful = done;
          firstRun = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 - 48,
      width: MediaQuery.of(context).size.width,
      child: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? ListView.builder(
                  itemExtent: 140,
                  itemCount: DummyData.nowPlaying.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = (widget.genreId != null)
                        ? Provider.of<MoviesProvider>(context)
                            .moviesByGenre[index]
                        : Provider.of<MoviesProvider>(context)
                            .trendingMovies[index];

                    bool isFav = Provider.of<MoviesProvider>(context)
                        .isFavorite(movie.id);
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              MovieDetailsScreen.routeName,
                              arguments: movie);
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    movie.posterUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  flex: 7,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      movie.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            '${movie.rating}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: RatingBar(
                                            initialRating: movie.rating / 2,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.all(4),
                                            itemBuilder: (context, index) {
                                              return Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              );
                                            },
                                            ignoreGestures: true,
                                            onRatingUpdate: null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            Positioned(
                                right: 10,
                                top: 5,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<MoviesProvider>(context,
                                            listen: false)
                                        .toggleFavoriteStatus(movie);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0),
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      (isFav)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
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
