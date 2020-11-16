import 'package:dio/dio.dart';
import 'package:roovies/helpers/api_keys.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/user.dart';

class FirebaseHandler {
  static FirebaseHandler _instance = FirebaseHandler._private();
  FirebaseHandler._private();
  static FirebaseHandler get instance => _instance;

  Dio _dio = Dio();
  Future<void> addFavorite(Movie movie) async {
    String url =
        'https://roovies-sat-2.firebaseio.com/users/userId/favorites/${movie.id}.json';
    await _dio.put(url, data: {
      'id': movie.id,
      'title': movie.title,
      'vote_average': movie.rating,
      'poster_path': movie.posterUrl.split('/').last,
      'backdrop_path': movie.backPosterUrl.split('/').last,
    });
  }

  Future<void> deleteFavorite(Movie movie) async {
    String url =
        'https://roovies-sat-2.firebaseio.com/users/userId/favorites/${movie.id}.json';
    await _dio.delete(url);
  }

  Future<User> register(String email, String password) async {
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
    final params = {'key': ApiKeys.firebaseKey};
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );
    return User.fromJson(response.data);
  }

  Future<User> login(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?';
    final params = {'key': ApiKeys.firebaseKey};
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );

    return User.fromJson(response.data);
  }
}
