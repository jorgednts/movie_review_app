import 'package:core/core.dart';

enum AppCollectionItemType {
  movie(storageValue: 'movie'),
  tvSeries(storageValue: 'tv_series');

  final String storageValue;

  const AppCollectionItemType({required this.storageValue});

  static AppCollectionItemType fromStorage(String value) {
    switch (value) {
      case 'movie':
        return AppCollectionItemType.movie;
      case 'tv_series':
      default:
        return AppCollectionItemType.tvSeries;
    }
  }
}

class AppCollectionItemModel
    implements CollectionItemModel<AppCollectionItemModel> {
  final AppCollectionItemType type;
  final String backdropPath;
  final int tmdbId;
  final String releaseDate;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final String title;
  final double voteAverage;

  AppCollectionItemModel({
    required this.type,
    required this.backdropPath,
    required this.tmdbId,
    required this.releaseDate,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  });

  @override
  AppCollectionItemModel fromStorage(Map<String, dynamic> json) {
    return AppCollectionItemModel(
      type: AppCollectionItemType.fromStorage(json['type']),
      backdropPath: json['backdrop_path'],
      tmdbId: json['tmdb_id'],
      releaseDate: json['release_date'],
      originalLanguage: json['original_language'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      title: json['title'],
      voteAverage: json['vote_average'],
    );
  }

  @override
  Map<String, dynamic> toStorage() {
    return {
      'type': type.storageValue,
      'backdrop_path': backdropPath,
      'tmdb_id': tmdbId,
      'release_date': releaseDate,
      'original_language': originalLanguage,
      'overview': overview,
      'poster_path': posterPath,
      'title': title,
      'vote_average': voteAverage,
    };
  }

  @override
  String get id => '$tmdbId-$title';
}