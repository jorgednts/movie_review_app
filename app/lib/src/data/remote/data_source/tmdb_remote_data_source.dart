import 'package:app/src/domain/model/movie_model.dart';
import 'package:core/core.dart';

abstract class TMDBRemoteDataSource {
  Future<Result<List<MovieModel>>> getPopularMovies();
}