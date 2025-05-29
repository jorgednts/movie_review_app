import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

abstract class BaseViewModel {
  BaseViewModel() {
    onInit();
  }

  @mustCallSuper
  void onInit() {
    initCommands();
  }

  void initCommands();

  Future<Result<OutputType>> callUseCase<InputType, OutputType>({
    required BaseUseCase<InputType, OutputType> useCase,
    required InputType input,
    required void Function(OutputType data) onSuccess,
    required void Function(Exception error) onError,
    void Function()? onFinally,
  }) async {
    final response = await useCase.call(input);
    response.fold(onOk: onSuccess, onError: onError);
    if (onFinally != null) onFinally();
    return response;
  }
}
