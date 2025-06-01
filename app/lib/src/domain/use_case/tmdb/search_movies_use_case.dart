import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class SearchMoviesUseCase
    implements
        BaseUseCase<
          MoviePaginatedRequestParameters,
          BaseTMDBPaginatedModel<MovieModel>
        > {
  final TMDBRepository _tmdbRepository;

  SearchMoviesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  Future<Result<BaseTMDBPaginatedModel<MovieModel>>> call(
    MoviePaginatedRequestParameters input,
  ) async {
    return await _tmdbRepository.searchMovies(params: input);
  }
}
