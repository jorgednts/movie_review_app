import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetTopRatedTVSeriesUseCase
    implements BaseUseCase<NoParam, List<TVSeriesModel>> {
  final TMDBRepository _tmdbRepository;

  GetTopRatedTVSeriesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<List<TVSeriesModel>> call(NoParam input) async {
    return await _tmdbRepository.getTopRatedTVSeries();
  }
}
