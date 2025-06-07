import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/cast_member_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class TMDBRepositoryImpl implements TMDBRepository {
  final TMDBRemoteDataSource _tmdbRemoteDataSource;

  TMDBRepositoryImpl({required TMDBRemoteDataSource tmdbRemoteDataSource})
    : _tmdbRemoteDataSource = tmdbRemoteDataSource;

  @override
  AsyncResult<List<MovieModel>> getPopularMovies() async {
    return await _tmdbRemoteDataSource.getPopularMovies();
  }

  @override
  AsyncResult<List<TVSeriesModel>> getPopularTVSeries() async {
    return await _tmdbRemoteDataSource.getPopularTVSeries();
  }

  @override
  AsyncResult<List<MovieModel>> getTopRatedMovies() async {
    return await _tmdbRemoteDataSource.getTopRatedMovies();
  }

  @override
  AsyncResult<List<TVSeriesModel>> getTopRatedTVSeries() async {
    return await _tmdbRemoteDataSource.getTopRatedTVSeries();
  }

  @override
  AsyncResult<String> createGuestSession() async {
    return await _tmdbRemoteDataSource.createGuestSession();
  }

  @override
  AsyncResult<BaseTMDBPaginatedModel<MovieModel>> searchMovies({
    required MoviePaginatedRequestParameters params,
  }) async {
    return await _tmdbRemoteDataSource.searchMovies(params: params);
  }

  @override
  AsyncResult<BaseTMDBPaginatedModel<TVSeriesModel>> searchTVSeries({
    required TVSeriesPaginatedRequestParameters params,
  }) async {
    return await _tmdbRemoteDataSource.searchTVSeries(params: params);
  }

  @override
  AsyncResult<BaseTMDBDetailsModel> getTMDBItemDetails({
    required BaseDetailsRequestParameters params,
  }) async {
    return await _tmdbRemoteDataSource.getTMDBItemDetails(params: params);
  }

  @override
  AsyncResult<List<MovieModel>> getSimilarMovies({
    required BaseDetailsRequestParameters params,
  }) async {
    return await _tmdbRemoteDataSource.getSimilarMovies(params: params);
  }

  @override
  AsyncResult<List<TVSeriesModel>> getSimilarTVSeries({
    required BaseDetailsRequestParameters params,
  }) async {
    return await _tmdbRemoteDataSource.getSimilarTVSeries(params: params);
  }

  @override
  AsyncResult<List<CastMemberModel>> getCastMembers({
    required BaseDetailsRequestParameters params,
  }) async {
    return await _tmdbRemoteDataSource.getCastMembers(params: params);
  }
}
