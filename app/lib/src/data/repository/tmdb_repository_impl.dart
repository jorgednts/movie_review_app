import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

import '../remote/data_source/tmdb_remote_data_source.dart';

class TMDBRepositoryImpl implements TMDBRepository {
  final TMDBRemoteDataSource _tmdbRemoteDataSource;

  TMDBRepositoryImpl({required TMDBRemoteDataSource tmdbRemoteDataSource})
    : _tmdbRemoteDataSource = tmdbRemoteDataSource;

  @override
  Future<Result<List<MovieModel>>> getPopularMovies() async {
    return await _tmdbRemoteDataSource.getPopularMovies();
  }
}
