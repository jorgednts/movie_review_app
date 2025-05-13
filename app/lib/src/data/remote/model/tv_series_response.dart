class TVSeriesResponse {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int? id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  TVSeriesResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) {
    try {
      final result = TVSeriesResponse(
        backdropPath: json['backdrop_path'] ?? '',
        firstAirDate: json['first_air_date'] ?? '',
        genreIds: List.from(json['genre_ids'] ?? []),
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        originCountry: List<String>.from(json['origin_country'] ?? []),
        originalLanguage: json['original_language'] ?? '',
        originalName: json['original_name'] ?? '',
        overview: json['overview'] ?? '',
        popularity: (json['popularity'] ?? 0.0).toDouble(),
        posterPath: json['poster_path'] ?? '',
        voteAverage: json['vote_average'] ?? 0.0,
        voteCount: json['vote_count'] ?? 0,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
