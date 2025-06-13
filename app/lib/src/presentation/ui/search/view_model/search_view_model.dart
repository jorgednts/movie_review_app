import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/app/get_search_suggestion_list_local_use_case.dart';
import 'package:app/src/domain/use_case/app/update_search_suggestion_list_local_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_tv_series_use_case.dart';
import 'package:app/src/presentation/utils/tmdb_paginated_list_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends BaseViewModel {
  // Use Cases
  final SearchMoviesUseCase _searchMoviesUseCase;
  final SearchTVSeriesUseCase _searchTVSeriesUseCase;
  final GetSearchSuggestionListLocalUseCase
  _getSearchSuggestionListLocalUseCase;
  final UpdateSearchSuggestionListLocalUseCase
  _updateSearchSuggestionListLocalUseCase;

  SearchViewModel({
    required SearchMoviesUseCase searchMoviesUseCase,
    required SearchTVSeriesUseCase searchTVSeriesUseCase,
    required GetSearchSuggestionListLocalUseCase
    getSearchSuggestionListLocalUseCase,
    required UpdateSearchSuggestionListLocalUseCase
    updateSearchSuggestionListLocalUseCase,
  }) : _searchMoviesUseCase = searchMoviesUseCase,
       _searchTVSeriesUseCase = searchTVSeriesUseCase,
       _getSearchSuggestionListLocalUseCase =
           getSearchSuggestionListLocalUseCase,
       _updateSearchSuggestionListLocalUseCase =
           updateSearchSuggestionListLocalUseCase;

  // Pagination Notifiers
  late final MoviePaginatedListNotifier searchMovies;
  late final TVSeriesPaginatedListNotifier searchTVSeries;
  late final Command0<void> getSuggestions;

  // Other Variables
  AppCollectionItemType selectedSegment = AppCollectionItemType.movie;
  SearchController searchController = SearchController();
  final ValueNotifier<bool> initState = ValueNotifier(true);
  final ValueNotifier<int?> totalResults = ValueNotifier(null);
  final ScrollController scrollController = ScrollController();
  List<String> suggestions = List.empty(growable: true);
  String language = 'en-US';

  @override
  void onInit() {
    super.onInit();
    getSuggestions.execute();
  }

  @override
  void initCommands() {
    searchMovies = MoviePaginatedListNotifier(_searchMovies);
    searchTVSeries = TVSeriesPaginatedListNotifier(_searchTVSeries);
    getSuggestions = Command0(_getSuggestions);
  }

  AsyncResult<BaseTMDBPaginatedModel<MovieModel>> _searchMovies(
    int page,
  ) async {
    return await _searchMoviesUseCase(
      MoviePaginatedRequestParameters(
        query: searchController.text,
        page: page,
        language: language,
      ),
    );
  }

  AsyncResult<BaseTMDBPaginatedModel<TVSeriesModel>> _searchTVSeries(
    int page,
  ) async {
    return await _searchTVSeriesUseCase(
      TVSeriesPaginatedRequestParameters(
        query: searchController.text,
        page: page,
        language: language,
      ),
    );
  }

  void handleSearch() {
    if (searchController.text.isEmpty) {
      initState.value = true;
      return;
    }
    if (initState.value) {
      initState.value = false;
    }
    resetPagination();
    _saveSuggestion(searchController.text);
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

  void _saveSuggestion(String suggestion) async {
    await _updateSearchSuggestionListLocalUseCase(suggestion);
    await _getSuggestions();
  }

  AsyncResult _getSuggestions() async {
    return await callUseCase<NoParam, List<String>>(
      useCase: _getSearchSuggestionListLocalUseCase,
      input: NoParam(),
      onSuccess: (result) {
        suggestions.clear();
        suggestions.addAll(result);
      },
      onError: (error) {},
    );
  }
}
