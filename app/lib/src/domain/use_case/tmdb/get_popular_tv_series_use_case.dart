import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetPopularTVSeriesUseCase
    implements BaseUseCase<NoParam, List<TVSeriesModel>> {
  final TMDBRepository _tmdbRepository;

  GetPopularTVSeriesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<List<TVSeriesModel>> call(NoParam input) async {
    return await _tmdbRepository.getPopularTVSeries();
  }
}
