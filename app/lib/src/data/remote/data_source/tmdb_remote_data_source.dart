import 'package:app/src/data/remote/model/base/base_request_parameters.dart';
import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';

abstract class TMDBRemoteDataSource {
  Future<List<T>> getPaginated<T>({
    required String uri,
    required T Function(Map<String, dynamic>) fromJsonT,
    Map<String, dynamic>? headers,
    BaseRequestParameters? queryParameters,
  });

  Future<Result<String>> createGuestSession();

  Future<Result<List<MovieModel>>> getPopularMovies();

  Future<Result<List<MovieModel>>> getTopRatedMovies();

  Future<Result<List<TVSeriesModel>>> getPopularTVSeries();

  Future<Result<List<TVSeriesModel>>> getTopRatedTVSeries();

  Future<Result<List<MovieModel>>> searchMovies({
    required MoviePaginatedRequestParameters params,
  });

  Future<Result<List<TVSeriesModel>>> searchTVSeries({
    required TVSeriesPaginatedRequestParameters params,
  });
}
