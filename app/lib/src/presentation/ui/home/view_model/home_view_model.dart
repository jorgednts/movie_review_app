import 'package:app/src/data/remote/model/request/movie_paginated_request_parameters.dart';
import 'package:app/src/data/remote/model/request/tv_series_paginated_request_parameters.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/tmdb/create_guest_session_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/search_tv_series_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends BaseViewModel {
  // Use Cases
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final GetPopularTVSeriesUseCase _getPopularTVSeriesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final GetTopRatedTVSeriesUseCase _getTopRatedTVSeriesUseCase;
  final CreateGuestSessionUseCase _createGuestSessionUseCase;
  final SearchMoviesUseCase _searchMoviesUseCase;
  final SearchTVSeriesUseCase _searchTVSeriesUseCase;

  HomeViewModel({
    required GetPopularMoviesUseCase getPopularMoviesUseCase,
    required GetPopularTVSeriesUseCase getPopularTVSeriesUseCase,
    required GetTopRatedMoviesUseCase getTopRatedMoviesUseCase,
    required GetTopRatedTVSeriesUseCase getTopRatedTVSeriesUseCase,
    required CreateGuestSessionUseCase createGuestSessionUseCase,
    required SearchMoviesUseCase searchMoviesUseCase,
    required SearchTVSeriesUseCase searchTVSeriesUseCase,
  }) : _getPopularMoviesUseCase = getPopularMoviesUseCase,
       _getPopularTVSeriesUseCase = getPopularTVSeriesUseCase,
       _getTopRatedMoviesUseCase = getTopRatedMoviesUseCase,
       _getTopRatedTVSeriesUseCase = getTopRatedTVSeriesUseCase,
       _createGuestSessionUseCase = createGuestSessionUseCase,
       _searchMoviesUseCase = searchMoviesUseCase,
       _searchTVSeriesUseCase = searchTVSeriesUseCase;

  // Commands
  late final Command0<void> fetchPopularMovies;
  late final Command0<void> fetchPopularTVSeries;
  late final Command0<void> fetchTopRatedMovies;
  late final Command0<void> fetchTopRatedTVSeries;
  late final Command0<void> createGuestSession;
  late final Command0<void> searchMovies;
  late final Command0<void> searchTVSeries;

  // Other Variables
  final List<MovieModel> popularMovies = [];
  final List<TVSeriesModel> popularTVSeries = [];
  final List<MovieModel> topRatedMovies = [];
  final List<TVSeriesModel> topRatedTVSeries = [];
  String? guestSessionId;

  @override
  void onInit() {
    super.onInit();

    fetchPopularMovies.execute();
    fetchPopularTVSeries.execute();
    fetchTopRatedMovies.execute();
    fetchTopRatedTVSeries.execute();
    createGuestSession.execute();
  }

  @override
  void initCommands() {
    fetchPopularMovies = Command0(_getPopularMovies);
    fetchPopularTVSeries = Command0(_getPopularTVSeries);
    fetchTopRatedMovies = Command0(_getTopRatedMovies);
    fetchTopRatedTVSeries = Command0(_getTopRatedTVSeries);
    createGuestSession = Command0(_createGuestSession);
    searchMovies = Command0(_searchMovies);
    searchTVSeries = Command0(_searchTVSeries);
  }

  Future<Result> _getPopularMovies() async {
    return await request<NoParam, List<MovieModel>>(
      useCase: _getPopularMoviesUseCase,
      input: NoParam(),
      onSuccess: (result) {
        popularMovies.clear();
        popularMovies.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  Future<Result<void>> _getPopularTVSeries() async {
    return await request<NoParam, List<TVSeriesModel>>(
      useCase: _getPopularTVSeriesUseCase,
      input: NoParam(),
      onSuccess: (result) {
        popularTVSeries.clear();
        popularTVSeries.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  Future<Result> _getTopRatedMovies() async {
    return await request<NoParam, List<MovieModel>>(
      useCase: _getTopRatedMoviesUseCase,
      input: NoParam(),
      onSuccess: (result) {
        topRatedMovies.clear();
        topRatedMovies.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  Future<Result<void>> _getTopRatedTVSeries() async {
    return await request<NoParam, List<TVSeriesModel>>(
      useCase: _getTopRatedTVSeriesUseCase,
      input: NoParam(),
      onSuccess: (result) {
        topRatedTVSeries.clear();
        topRatedTVSeries.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  Future<Result<void>> _createGuestSession() async {
    return await request<NoParam, String>(
      useCase: _createGuestSessionUseCase,
      input: NoParam(),
      onSuccess: (result) {
        guestSessionId = result;
      },
      onError: (error) {
        guestSessionId = null;
      },
    );
  }

  Future<Result<void>> _searchMovies() async {
    return await request<MoviePaginatedRequestParameters, List<MovieModel>>(
      useCase: _searchMoviesUseCase,
      input: MoviePaginatedRequestParameters(query: 'Hunger Games'),
      onSuccess: (result) {
        for (var movie in result) {
          debugPrint('MOVIES SEARCH: ${movie.title}');
        }
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  Future<Result<void>> _searchTVSeries() async {
    return await request<
      TVSeriesPaginatedRequestParameters,
      List<TVSeriesModel>
    >(
      useCase: _searchTVSeriesUseCase,
      input: TVSeriesPaginatedRequestParameters(query: 'Friends'),
      onSuccess: (result) {
        for (var tvSeries in result) {
          debugPrint('TV SERIES SEARCH: ${tvSeries.name}');
        }
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }
}
