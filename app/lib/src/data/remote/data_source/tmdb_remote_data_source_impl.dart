import 'package:app/src/data/mapper/tmdb_mapper.dart';
import 'package:app/src/data/remote/client/custom_http_client.dart';
import 'package:app/src/data/remote/data_source/api_constants/tmdb_api_constants.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/data/remote/model/base/base_request_parameters.dart';
import 'package:app/src/data/remote/model/base/base_tmdb_details_response.dart';
import 'package:app/src/data/remote/model/base/base_tmdb_paginated_response.dart';
import 'package:app/src/data/remote/model/guest_session_response.dart';
import 'package:app/src/data/remote/model/movie_response.dart';
import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/tv_series_response.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';

class TMDBRemoteDataSourceImpl implements TMDBRemoteDataSource {
  final CustomHttpClient _client;

  TMDBRemoteDataSourceImpl({required CustomHttpClient client})
    : _client = client;

  @override
  Future<BaseTMDBPaginatedResponse<T>> getPaginated<T>({
    required String uri,
    required T Function(Map<String, dynamic>) fromJsonT,
    Map<String, dynamic>? headers,
    BaseRequestParameters? queryParameters,
  }) async {
    final data = await _client.get(
      uri,
      headers: headers,
      queryParameters: queryParameters?.toJson(),
    );
    final paginated = BaseTMDBPaginatedResponse<T>.fromJson(
      json: data,
      fromJsonT: fromJsonT,
    );
    return paginated;
  }

  @override
  Future<Result<String>> createGuestSession() async {
    try {
      final data = await _client.get(
        '${TMDBApiConstants.baseUrl}/${TMDBApiConstants.guestSessionEndpoint}',
      );

      final session = GuestSessionResponse.fromJson(data);
      if (session.success) {
        return Result.ok(session.guestSessionId);
      } else {
        return Result.error(Exception());
      }
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<MovieModel>>> getPopularMovies() async {
    try {
      final response = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/movie/${TMDBApiConstants.popularEndpoint}',
        fromJsonT: MovieResponse.fromJson,
      );
      return Result.ok(response.results.toMovieModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<TVSeriesModel>>> getPopularTVSeries() async {
    try {
      final response = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/tv/${TMDBApiConstants.popularEndpoint}',
        fromJsonT: TVSeriesResponse.fromJson,
      );
      return Result.ok(response.results.toTVSeriesModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<MovieModel>>> getTopRatedMovies() async {
    try {
      final response = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/movie/${TMDBApiConstants.topRatedEndpoint}',
        fromJsonT: MovieResponse.fromJson,
      );
      return Result.ok(response.results.toMovieModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<TVSeriesModel>>> getTopRatedTVSeries() async {
    try {
      final response = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/tv/${TMDBApiConstants.topRatedEndpoint}',
        fromJsonT: TVSeriesResponse.fromJson,
      );
      return Result.ok(response.results.toTVSeriesModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<BaseTMDBPaginatedModel<MovieModel>>> searchMovies({
    required MoviePaginatedRequestParameters params,
  }) async {
    try {
      final response = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/${TMDBApiConstants.searchMovieEndpoint}',
        fromJsonT: MovieResponse.fromJson,
        queryParameters: params,
      );
      return Result.ok(
        response.toPaginatedModel<MovieModel>(
          response.results.toMovieModelList(),
        ),
      );
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<BaseTMDBPaginatedModel<TVSeriesModel>>> searchTVSeries({
    required TVSeriesPaginatedRequestParameters params,
  }) async {
    try {
      final response = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/${TMDBApiConstants.searchTVSeriesEndpoint}',
        fromJsonT: TVSeriesResponse.fromJson,
        queryParameters: params,
      );
      return Result.ok(
        response.toPaginatedModel(response.results.toTVSeriesModelList()),
      );
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<BaseTMDBDetailsModel>> getTMDBItemDetails({
    required BaseDetailsRequestParameters params,
  }) async {
    try {
      final response = await _client.get(
        '${TMDBApiConstants.baseUrl}/${params.type == AppCollectionItemType.movie ? TMDBApiConstants.movieDetailsEndpoint : TMDBApiConstants.tvSeriesDetailsEndpoint}/${params.uid}',
        queryParameters: params.toJson(),
      );
      return Result.ok(
        BaseTMDBDetailsResponse.fromJson(response).toBaseTMDBDetailsModel(),
      );
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<BaseTMDBDetailsModel>> getMovieDetails({
    required BaseDetailsRequestParameters params,
  }) async {
    try {
      final response = await _client.get(
        '${TMDBApiConstants.baseUrl}/${TMDBApiConstants.movieDetailsEndpoint}/${params.uid}',
        queryParameters: params.toJson(),
      );
      return Result.ok(
        BaseTMDBDetailsResponse.fromJson(response).toBaseTMDBDetailsModel(),
      );
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
