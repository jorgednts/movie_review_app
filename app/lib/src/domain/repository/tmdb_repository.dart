import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';

abstract class TMDBRepository {
  Future<Result<List<MovieModel>>> getPopularMovies();

  Future<Result<List<MovieModel>>> getTopRatedMovies();

  Future<Result<List<TVSeriesModel>>> getPopularTVSeries();

  Future<Result<List<TVSeriesModel>>> getTopRatedTVSeries();
}
