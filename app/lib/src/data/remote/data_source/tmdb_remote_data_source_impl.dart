import 'package:app/src/data/mapper/tmdb_mapper.dart';
import 'package:app/src/data/remote/client/custom_http_client.dart';
import 'package:app/src/data/remote/data_source/api_constants/tmdb_api_constants.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/model/base/base_tmdb_paginated_response.dart';
import 'package:app/src/data/remote/model/guest_session_response.dart';
import 'package:app/src/data/remote/model/movie_response.dart';
import 'package:app/src/data/remote/model/tv_series_response.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';

class TMDBRemoteDataSourceImpl implements TMDBRemoteDataSource {
  final CustomHttpClient _client;

  TMDBRemoteDataSourceImpl({required CustomHttpClient client})
    : _client = client;

  Future<List<T>> getPaginated<T>({
    required String uri,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    final data = await _client.get(uri);
    final paginated = BaseTMDBPaginatedResponse<T>.fromJson(
      json: data,
      fromJsonT: fromJsonT,
    );
    return paginated.results;
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
        return Result.error(Exception('Falha ao criar sessão'));
      }
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<MovieModel>>> getPopularMovies() async {
    try {
      final movies = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/movie/${TMDBApiConstants.popularEndpoint}',
        fromJsonT: MovieResponse.fromJson,
      );
      return Result.ok(movies.toMovieModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<TVSeriesModel>>> getPopularTVSeries() async {
    try {
      final tvSeries = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/tv/${TMDBApiConstants.popularEndpoint}',
        fromJsonT: TVSeriesResponse.fromJson,
      );
      return Result.ok(tvSeries.toTVSeriesModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<MovieModel>>> getTopRatedMovies() async {
    try {
      final movies = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/movie/${TMDBApiConstants.topRatedEndpoint}',
        fromJsonT: MovieResponse.fromJson,
      );
      return Result.ok(movies.toMovieModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<List<TVSeriesModel>>> getTopRatedTVSeries() async {
    try {
      final tvSeries = await getPaginated(
        uri:
            '${TMDBApiConstants.baseUrl}/tv/${TMDBApiConstants.topRatedEndpoint}',
        fromJsonT: TVSeriesResponse.fromJson,
      );
      return Result.ok(tvSeries.toTVSeriesModelList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
