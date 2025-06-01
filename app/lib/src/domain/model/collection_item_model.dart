import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

enum AppCollectionItemType {
  movie(storageValue: 'movie', icon: Icons.local_movies_outlined),
  tvSeries(storageValue: 'tv_series', icon: Icons.tv);

  final String storageValue;
  final IconData icon;

  const AppCollectionItemType({required this.storageValue, required this.icon});

  static AppCollectionItemType fromStorage(String value) {
    switch (value) {
      case 'movie':
        return AppCollectionItemType.movie;
      case 'tv_series':
      default:
        return AppCollectionItemType.tvSeries;
    }
  }

  String nameTranslated(BuildContext context) {
    switch (this) {
      case AppCollectionItemType.movie:
        return AppIntl.of(context).common_movies;
      case AppCollectionItemType.tvSeries:
        return AppIntl.of(context).common_tv_series;
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
