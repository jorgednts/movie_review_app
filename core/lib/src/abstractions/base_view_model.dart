 abstract class BaseViewModel {
  BaseViewModel() {
    onInit();
  }

  Future<void> onInit();
}
