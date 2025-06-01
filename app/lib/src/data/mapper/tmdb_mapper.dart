import 'package:app/src/data/remote/model/base/base_tmdb_paginated_response.dart';
import 'package:app/src/data/remote/model/guest_session_response.dart';
import 'package:app/src/data/remote/model/movie_response.dart';
import 'package:app/src/data/remote/model/tv_series_response.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/guest_session_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';

extension MovieResponseMapper on MovieResponse {
  MovieModel toMovieModel() {
    return MovieModel(
      adult: adult ?? false,
      backdropPath: backdropPath ?? '',
      genreIds:
          (genreIds ?? [])
              .map((e) => int.tryParse(e.toString()) ?? -1)
              .toList(),
      id: id ?? 0,
      originalLanguage: originalLanguage ?? '',
      originalTitle: originalTitle ?? '',
      overview: overview ?? '',
      popularity: (popularity ?? 0).toDouble(),
      posterPath: posterPath ?? '',
      releaseDate: releaseDate ?? '',
      title: title ?? '',
      video: video ?? false,
      voteAverage: (voteAverage ?? 0).toDouble(),
      voteCount: voteCount ?? 0,
    );
  }
}

extension ListMovieResponseMapper on List<MovieResponse> {
  List<MovieModel> toMovieModelList() {
    return map((e) => e.toMovieModel()).toList();
  }
}

extension TVSeriesResponseMapper on TVSeriesResponse {
  TVSeriesModel toTVSeriesModel() {
    return TVSeriesModel(
      backdropPath: backdropPath ?? '',
      firstAirDate: firstAirDate ?? '',
      genreIds:
          (genreIds ?? [])
              .map((e) => int.tryParse(e.toString()) ?? -1)
              .toList(),
      id: id ?? 0,
      name: name ?? '',
      originCountry: (originCountry ?? []).map((e) => e).toList(),
      originalLanguage: originalLanguage ?? '',
      originalName: originalName ?? '',
      overview: overview ?? '',
      popularity: (popularity ?? 0.0),
      posterPath: posterPath ?? '',
      voteAverage: (voteAverage ?? 0.0),
      voteCount: voteCount ?? 0,
    );
  }
}

extension ListTVSeriesResponseMapper on List<TVSeriesResponse> {
  List<TVSeriesModel> toTVSeriesModelList() {
    return map((e) => e.toTVSeriesModel()).toList();
  }
}

extension GuestSessionResponseMapper on GuestSessionResponse {
  GuestSessionModel toGuestSessionModel() {
    return GuestSessionModel(
      success: success,
      guestSessionId: guestSessionId,
      expiresAt: expiresAt,
    );
  }
}

extension BaseTMDBPaginatedResponseMapper on BaseTMDBPaginatedResponse {
  BaseTMDBPaginatedModel<T> toPaginatedModel<T>(List<T> items) {
    return BaseTMDBPaginatedModel<T>(
      page: page,
      results: items,
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
