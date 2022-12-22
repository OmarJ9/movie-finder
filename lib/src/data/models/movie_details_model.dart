class MovieDetailsModel {
  final int budget;
  final String status;
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final num voteAverage;
  final String backdropPath;
  final String posterPath;
  final double popularity;
  final List<dynamic> genres;
  final int revenue;
  final int runtime;

  const MovieDetailsModel({
    required this.budget,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.backdropPath,
    required this.posterPath,
    required this.popularity,
    required this.genres,
  });

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailsModel(
      budget: map['budget']?.toInt() ?? 0,
      genres: List<Genres>.from(map['genres']?.map((x) => Genres.fromJson(x))),
      revenue: map['revenue']?.toInt() ?? 0,
      runtime: map['runtime']?.toInt() ?? 0,
      status: map['status'] ?? '',
      id: map['id']?.toInt() ?? 0,
      backdropPath: map['backdrop_path'] ?? '',
      title: map['title'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      overview: map['overview'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
    );
  }

  @override
  String toString() {
    return "title : $title, vote : $voteAverage , date : $releaseDate ";
  }
}

class Genres {
  final int id;
  final String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
