class FavoriteMocvie {
  final int movieID;
  final String posterPath;
  final String title;
  final String overview;
  final String userID;

  FavoriteMocvie(
      {required this.movieID,
      required this.posterPath,
      required this.title,
      required this.overview,
      required this.userID});

  factory FavoriteMocvie.fromJson(Map<String, dynamic> json) {
    return FavoriteMocvie(
      movieID: json['movie_id'],
      posterPath: json['movie_poster'],
      title: json['title'],
      overview: json['overview'],
      userID: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieID,
      'movie_poster': posterPath,
      'title': title,
      'overview': overview,
      'user_id': userID,
    };
  }
}
