import 'package:flutter/material.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/models/tmdb_handler.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlaying;
  List<Movie> moviesByGenre;
  List<Movie> trendingMovies;

  Future<bool> fetchNowPlayingMovies() async {
    try {
      nowPlaying = await TMDBHandler.instance.getNowPlaying();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchMoviesByGenreId(int genreId) async {
    try {
      moviesByGenre = await TMDBHandler.instance.getMoviesByGenre(genreId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      trendingMovies = await TMDBHandler.instance.getTrendingMovies();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<MovieDetails> fetchMovieDetailsById(int movieId) async {
    try {
      return await TMDBHandler.instance.getMovieDetailsById(movieId);
    } catch (error) {
      return null;
    }
  }
}
