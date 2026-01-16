import 'package:app/src/domain/repository/app_repository.dart';
import 'package:core/core.dart';

class GetThemeModeLocalUseCase extends BaseUseCase<NoParam, bool?> {
  final AppRepository _appRepository;

  GetThemeModeLocalUseCase({required AppRepository appRepository})
    : _appRepository = appRepository;

  @override
  AsyncResult<bool?> call(NoParam input) async {
    return await _appRepository.getThemeMode();
  }
}
