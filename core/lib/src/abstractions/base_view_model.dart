import 'package:core/core.dart';

abstract class BaseViewModel {
  BaseViewModel() {
    onInit();
  }

  void onInit();

  Future<Result<OutputType>> fetchData<InputType, OutputType>({
    required BaseUseCase<InputType, OutputType> useCase,
    required InputType input,
    required void Function(OutputType data) onSuccess,
    required void Function(Exception error) onError,
  }) async {
    final response = await useCase.call(input);
    response.handle(onOk: onSuccess, onError: onError);
    return response;
  }
}
