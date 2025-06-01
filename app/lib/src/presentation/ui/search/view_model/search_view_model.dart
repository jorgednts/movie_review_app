import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/tmdb/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_tv_series_use_case.dart';
import 'package:app/src/presentation/utils/tmdb_paginated_list_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends BaseViewModel {
  // Use Cases
  final SearchMoviesUseCase _searchMoviesUseCase;
  final SearchTVSeriesUseCase _searchTVSeriesUseCase;

  SearchViewModel({
    required SearchMoviesUseCase searchMoviesUseCase,
    required SearchTVSeriesUseCase searchTVSeriesUseCase,
  }) : _searchMoviesUseCase = searchMoviesUseCase,
       _searchTVSeriesUseCase = searchTVSeriesUseCase;

  // Pagination Notifiers
  late final MoviePaginatedListNotifier searchMovies;
  late final TVSeriesPaginatedListNotifier searchTVSeries;

  // Other Variables
  AppCollectionItemType selectedSegment = AppCollectionItemType.movie;
  SearchController searchController = SearchController();
  final ValueNotifier<bool> initState = ValueNotifier(true);
  final ValueNotifier<int?> totalResults = ValueNotifier(null);
  final ScrollController scrollController = ScrollController();

  @override
  void initCommands() {
    searchMovies = MoviePaginatedListNotifier(_searchMovies);
    searchTVSeries = TVSeriesPaginatedListNotifier(_searchTVSeries);
  }

  Future<Result<BaseTMDBPaginatedModel<MovieModel>>> _searchMovies(
    int page,
  ) async {
    return await _searchMoviesUseCase(
      MoviePaginatedRequestParameters(query: searchController.text, page: page),
    );
  }

  Future<Result<BaseTMDBPaginatedModel<TVSeriesModel>>> _searchTVSeries(
    int page,
  ) async {
    return await _searchTVSeriesUseCase(
      TVSeriesPaginatedRequestParameters(
        query: searchController.text,
        page: page,
      ),
    );
  }

  void handleSearch() {
    if (initState.value) {
      initState.value = false;
    }
    resetPagination();
    switch (selectedSegment) {
      case AppCollectionItemType.movie:
        searchMovies.loadNextPage();
        break;

      case AppCollectionItemType.tvSeries:
        searchTVSeries.loadNextPage();
        break;
    }
  }

  void onSegmentChange(AppCollectionItemType segment) {
    selectedSegment = segment;
    resetPagination();
    handleSearch();
  }

  void triggerSearchFromSelection(String value) {
    searchController.closeView(value);
    resetPagination();
    handleSearch();
  }

  void resetPagination() {
    searchMovies.reset();
    searchTVSeries.reset();
  }
}
