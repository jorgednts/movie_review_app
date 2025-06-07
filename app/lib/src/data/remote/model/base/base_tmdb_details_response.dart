class BaseTMDBDetailsResponse {
  final bool adult;
  final String? backdropPath;
  final List<String>? genres;
  final String? homepage;
  final int id;
  final List<String>? originCountry;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String status;
  final String? tagline;
  final double voteAverage;
  final int voteCount;
  final String title;
  final String? date;
  final int? numberOfSeasons;

  BaseTMDBDetailsResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
    required this.title,
    required this.date,
    required this.numberOfSeasons,
  });

  factory BaseTMDBDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BaseTMDBDetailsResponse(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genres:
          (json['genres'] as List<dynamic>)
              .map((e) => e['name'].toString())
              .toList(),
      homepage: json['homepage'],
      id: json['id'],
      originCountry:
          (json['origin_country'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
      originalLanguage: json['original_language'],
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      status: json['status'] ?? '',
      tagline: json['tagline'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      title: json['title'] ?? json['name'],
      date: json['release_date'] ?? json['first_air_date'],
      numberOfSeasons: json['number_of_seasons'],
    );
  }
}
