import 'package:app/src/data/remote/data_source/tmdb_remote_data_source.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class TMDBRepositoryImpl implements TMDBRepository {
  final TMDBRemoteDataSource _tmdbRemoteDataSource;

  TMDBRepositoryImpl({required TMDBRemoteDataSource tmdbRemoteDataSource})
    : _tmdbRemoteDataSource = tmdbRemoteDataSource;

  @override
  Future<Result<List<MovieModel>>> getPopularMovies() async {
    return await _tmdbRemoteDataSource.getPopularMovies();
  }

  @override
  Future<Result<List<TVSeriesModel>>> getPopularTVSeries() async {
    return await _tmdbRemoteDataSource.getPopularTVSeries();
  }

  @override
  Future<Result<List<MovieModel>>> getTopRatedMovies() async {
    return await _tmdbRemoteDataSource.getTopRatedMovies();
  }

  @override
  Future<Result<List<TVSeriesModel>>> getTopRatedTVSeries() async {
    return await _tmdbRemoteDataSource.getTopRatedTVSeries();
  }
}
