import 'package:internationalization/internationalization.dart';

class TVSeriesModel {
  final String backdropPath;
  final String firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TVSeriesModel({
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

  String get posterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';

  String get releaseYear => firstAirDate.toDateFormat().year.toString();

  String get storageId => '$id-$name';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TVSeriesModel &&
        other.backdropPath == backdropPath &&
        other.firstAirDate == firstAirDate &&
        _listEquals(other.genreIds, genreIds) &&
        other.id == id &&
        other.name == name &&
        _listEquals(other.originCountry, originCountry) &&
        other.originalLanguage == originalLanguage &&
        other.originalName == originalName &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode =>
      backdropPath.hashCode ^
      firstAirDate.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      name.hashCode ^
      originCountry.hashCode ^
      originalLanguage.hashCode ^
      originalName.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode;

  bool _listEquals(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
