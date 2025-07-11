import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class SearchTVSeriesUseCase
    implements
        BaseUseCase<
          TVSeriesPaginatedRequestParameters,
          BaseTMDBPaginatedModel<TVSeriesModel>
        > {
  final TMDBRepository _tmdbRepository;

  SearchTVSeriesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<BaseTMDBPaginatedModel<TVSeriesModel>> call(
    TVSeriesPaginatedRequestParameters input,
  ) async {
    return await _tmdbRepository.searchTVSeries(params: input);
  }
}
