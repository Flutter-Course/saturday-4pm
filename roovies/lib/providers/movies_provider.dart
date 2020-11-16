import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roovies/models/firebase_handler.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/models/tmdb_handler.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowPlaying;
  List<Movie> moviesByGenre;
  List<Movie> trendingMovies;
  List<Movie> favorites = [];
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

  Future<String> fetchVideoById(int movieId) async {
    try {
      return await TMDBHandler.instance.getVideoById(movieId);
    } catch (error) {
      return null;
    }
  }

  void toggleFavoriteStatus(Movie movie) async {
    try {
      if (isFavorite(movie.id)) {
        await FirebaseHandler.instance.deleteFavorite(movie);
        favorites.removeWhere((element) {
          return element.id == movie.id;
        });
      } else {
        await FirebaseHandler.instance.addFavorite(movie);
        favorites.add(movie);
      }

      notifyListeners();
    } on DioError catch (error) {
      print(error.response);
    }
  }

  bool isFavorite(int movieId) {
    return favorites.any((element) => element.id == movieId);
  }
}
