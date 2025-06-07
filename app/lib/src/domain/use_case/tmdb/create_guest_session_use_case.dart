import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class CreateGuestSessionUseCase implements BaseUseCase<NoParam, String> {
  final TMDBRepository _tmdbRepository;

  CreateGuestSessionUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<String> call(NoParam input) async {
    return await _tmdbRepository.createGuestSession();
  }
}
