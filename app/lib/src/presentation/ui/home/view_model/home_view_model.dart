import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/tmdb/create_guest_session_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_tv_series_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends BaseViewModel {
  // Use Cases
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final GetPopularTVSeriesUseCase _getPopularTVSeriesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final GetTopRatedTVSeriesUseCase _getTopRatedTVSeriesUseCase;
  final CreateGuestSessionUseCase _createGuestSessionUseCase;

  HomeViewModel({
    required GetPopularMoviesUseCase getPopularMoviesUseCase,
    required GetPopularTVSeriesUseCase getPopularTVSeriesUseCase,
    required GetTopRatedMoviesUseCase getTopRatedMoviesUseCase,
    required GetTopRatedTVSeriesUseCase getTopRatedTVSeriesUseCase,
    required CreateGuestSessionUseCase createGuestSessionUseCase,
  }) : _getPopularMoviesUseCase = getPopularMoviesUseCase,
       _getPopularTVSeriesUseCase = getPopularTVSeriesUseCase,
       _getTopRatedMoviesUseCase = getTopRatedMoviesUseCase,
       _getTopRatedTVSeriesUseCase = getTopRatedTVSeriesUseCase,
       _createGuestSessionUseCase = createGuestSessionUseCase;

  // Commands
  late final Command0<void> fetchPopularMovies;
  late final Command0<void> fetchPopularTVSeries;
  late final Command0<void> fetchTopRatedMovies;
  late final Command0<void> fetchTopRatedTVSeries;
  late final Command0<void> createGuestSession;

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
  }

  Future<Result> _getPopularMovies() async {
    return await callUseCase<NoParam, List<MovieModel>>(
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
    return await callUseCase<NoParam, List<TVSeriesModel>>(
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
    return await callUseCase<NoParam, List<MovieModel>>(
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
    return await callUseCase<NoParam, List<TVSeriesModel>>(
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
    return await callUseCase<NoParam, String>(
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
}
