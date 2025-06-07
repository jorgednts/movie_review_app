import 'package:internationalization/internationalization.dart';

class BaseTMDBDetailsModel {
  final bool adult;
  final String backdropPath;
  final List<String> genres;
  final String? homepage;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;
  final String title;
  final String date;
  final int numberOfSeasons;

  BaseTMDBDetailsModel({
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

  String get posterUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';

  String get backdropUrl => 'https://image.tmdb.org/t/p/original/$backdropPath';

  String get releaseYear => date.toDateFormat().year.toString();

  String get condensedGenres => genres.join(', ');
}
