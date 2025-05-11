import 'dart:convert';

import 'package:app/src/data/mapper/tmdb_mapper.dart';
import 'package:app/src/data/remote/data_source/api_constants/tmdb_api_constants.dart';
import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/data/remote/model/base/base_tmdb_paginated_response.dart';
import 'package:app/src/data/remote/model/movie_response.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TMDBRemoteDataSourceImpl implements TMDBRemoteDataSource {
  Future<List<T>> getPaginated<T>({
    required String uri,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    final data = await get(uri: uri);
    final paginated = BaseTMDBPaginatedResponse<T>.fromJson(
      json: data,
      fromJsonT: fromJsonT,
    );
    return paginated.results;
  }

  Future<dynamic> get({required String uri}) async {
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['TMDB_API_TOKEN']}',
        // 'Content-Type': 'application/json;charset=utf-8',
      },
    );
    return jsonDecode(response.body);
  }

  @override
  Future<Result<List<MovieModel>>> getPopularMovies() async {
    try {
      final movies = await getPaginated(
        uri: '${TMDBApiConstants.baseUrl}/movie/popular',
        fromJsonT: MovieResponse.fromJson,
      );
      debugPrint(List.from(movies.map((e) => e.toMovieModel())).toString());
      return Result.ok(movies.toMovieModelList());
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(Exception(e));
    }
  }
}
