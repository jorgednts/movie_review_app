import 'package:app/src/domain/repository/app_repository.dart';
import 'package:core/core.dart';

class SetThemeModeLocalUseCase extends BaseUseCase<bool, void> {
  final AppRepository _appRepository;

  SetThemeModeLocalUseCase({required AppRepository appRepository})
    : _appRepository = appRepository;

  @override
  Future<Result<void>> call(bool input) async {
    return await _appRepository.setThemeMode(isDarkMode: input);
  }
}
