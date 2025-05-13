import 'package:core/core.dart';

abstract class BaseViewModel {
  BaseViewModel() {
    onInit();
  }

  void onInit();

  Future<Result<void>> fetchPaginatedData<T>(BaseUseCase useCase) async {
    final result = await useCase.call(NoParam());
    switch (result) {
      case Ok():
        return Result.ok(null);
      case Error():
        return Result.error(result.error);
    }
  }
}
