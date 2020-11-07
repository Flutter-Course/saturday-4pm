class Movie {
  final int id;
  final String title, posterUrl, backPosterUrl;
  final double rating;

  Movie.fromJson(dynamic json)
      : this.id = json['id'],
        this.title = json['title'],
        this.posterUrl =
            'https://image.tmdb.org/t/p/original/${json['poster_path']}',
        this.backPosterUrl =
            'https://image.tmdb.org/t/p/original/${json['backdrop_path']}',
        this.rating = json['vote_average'].toDouble();
}
