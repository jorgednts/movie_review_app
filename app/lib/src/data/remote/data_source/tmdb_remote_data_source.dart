import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/data/remote/model/base/base_request_parameters.dart';
import 'package:app/src/data/remote/model/base/base_tmdb_paginated_response.dart';
import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';

abstract class TMDBRemoteDataSource {
  Future<BaseTMDBPaginatedResponse<T>> getPaginated<T>({
    required String uri,
    required T Function(Map<String, dynamic>) fromJsonT,
    Map<String, dynamic>? headers,
    BaseRequestParameters? queryParameters,
  });

  AsyncResult<String> createGuestSession();

  AsyncResult<List<MovieModel>> getPopularMovies();

  AsyncResult<List<MovieModel>> getTopRatedMovies();

  AsyncResult<List<TVSeriesModel>> getPopularTVSeries();

  AsyncResult<List<TVSeriesModel>> getTopRatedTVSeries();

  AsyncResult<BaseTMDBPaginatedModel<MovieModel>> searchMovies({
    required MoviePaginatedRequestParameters params,
  });

  AsyncResult<BaseTMDBPaginatedModel<TVSeriesModel>> searchTVSeries({
    required TVSeriesPaginatedRequestParameters params,
  });

  AsyncResult<BaseTMDBDetailsModel> getTMDBItemDetails({
    required BaseDetailsRequestParameters params,
  });
}
