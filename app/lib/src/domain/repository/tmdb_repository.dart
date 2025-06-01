import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';

abstract class TMDBRepository {
  Future<Result<String>> createGuestSession();

  Future<Result<List<MovieModel>>> getPopularMovies();

  Future<Result<List<MovieModel>>> getTopRatedMovies();

  Future<Result<List<TVSeriesModel>>> getPopularTVSeries();

  Future<Result<List<TVSeriesModel>>> getTopRatedTVSeries();

  Future<Result<BaseTMDBPaginatedModel<MovieModel>>> searchMovies({
    required MoviePaginatedRequestParameters params,
  });

  Future<Result<BaseTMDBPaginatedModel<TVSeriesModel>>> searchTVSeries({
    required TVSeriesPaginatedRequestParameters params,
  });
}
