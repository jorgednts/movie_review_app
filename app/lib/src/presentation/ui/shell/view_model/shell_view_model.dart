import 'package:app/src/domain/use_case/auth/check_user_logged_use_case.dart';
import 'package:app/src/domain/use_case/auth/create_user_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_in_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_out_use_case.dart';
import 'package:app/src/domain/use_case/storage/create_user_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:app/src/presentation/ui/shell/widgets/auth_dialog.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';

enum AuthMessageType { signIn, signOut, createUser }

class ShellViewModel extends BaseViewModel {
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final CreateUserUseCase _createUserUseCase;
  final CheckUserLoggedUseCase _checkUserLoggedUseCase;
  final DialogEventNotifier<AuthMessageType> _dialogEventNotifier;
  final CreateUserStorageUseCase _createUserStorageUseCase;
  final UserStorageChangeNotifier _userChangeNotifier;
  final ThemeNotifier _themeNotifier;

  // Commands
  late final Command1<void, UserRequest> signIn;
  late final Command0<void> signOut;
  late final Command1<void, UserRequest> createUser;
  late final Command0<void> checkUserLogged;

  ShellViewModel({
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
    required CreateUserUseCase createUserUseCase,
    required CheckUserLoggedUseCase checkUserLoggedUseCase,
    required DialogEventNotifier<AuthMessageType> dialogEventNotifier,
    required UserStorageChangeNotifier userChangeNotifier,
    required CreateUserStorageUseCase createUserStorageUseCase,
    required GetCollectionFromStorageUseCase getUserStorageUseCase,
    required ThemeNotifier themeNotifier,
  }) : _signInUseCase = signInUseCase,
       _signOutUseCase = signOutUseCase,
       _createUserUseCase = createUserUseCase,
       _checkUserLoggedUseCase = checkUserLoggedUseCase,
       _dialogEventNotifier = dialogEventNotifier,
       _userChangeNotifier = userChangeNotifier,
       _createUserStorageUseCase = createUserStorageUseCase,
       _themeNotifier = themeNotifier;

  @override
  void onInit() {
    super.onInit();
    checkUserLogged.execute();
  }

  @override
  void initCommands() {
    signIn = Command1(_signIn);
    signOut = Command0(_signOut);
    createUser = Command1(_createUser);
    checkUserLogged = Command0(_checkUserLogged);
  }

  Future<Result> _signIn(UserRequest input) async {
    return await callUseCase<UserRequest, UserModel?>(
      useCase: _signInUseCase,
      input: input,
      onSuccess: (result) {
        userChangeNotifier.setUser(result);
      },
      onError: (error) {
        userChangeNotifier.setUser(null);
      },
      onFinally: () {
        _dialogEventNotifier.trigger(AuthMessageType.signIn);
      },
    );
  }

  Future<Result> _signOut() async {
    return await callUseCase<NoParam, void>(
      useCase: _signOutUseCase,
      input: NoParam(),
      onSuccess: (result) {
        userChangeNotifier.setUser(null);
      },
      onError: (error) {},
      onFinally: () {
        _dialogEventNotifier.trigger(AuthMessageType.signOut);
      },
    );
  }

  Future<Result> _createUser(UserRequest input) async {
    return await callUseCase<UserRequest, UserModel>(
      useCase: _createUserUseCase,
      input: input,
      onSuccess: (result) {
        final userStorageRequest = CreateUserStorageRequest(
          user: result,
          name: input.name,
        );
        _createUserStorage(userStorageRequest);
      },
      onError: (error) {},
      onFinally: () {
        _dialogEventNotifier.trigger(AuthMessageType.createUser);
      },
    );
  }

  Future<Result> _checkUserLogged() async {
    return await callUseCase<NoParam, UserModel?>(
      useCase: _checkUserLoggedUseCase,
      input: NoParam(),
      onSuccess: (result) {
        userChangeNotifier.setUser(result);
      },
      onError: (error) {
        userChangeNotifier.setUser(null);
      },
    );
  }

  Future<Result> _createUserStorage(
    CreateUserStorageRequest storageRequest,
  ) async {
    return await callUseCase<CreateUserStorageRequest, void>(
      useCase: _createUserStorageUseCase,
      input: storageRequest,
      onSuccess: (result) {},
      onError: (error) {},
    );
  }

  void handleAuthDialogResult(AuthDialogResult? result) {
    if (result != null) {
      switch (result.state) {
        case AuthDialogState.signIn:
          signIn.execute(result.userRequest!);
          break;
        case AuthDialogState.create:
          createUser.execute(result.userRequest!);
          break;
        case AuthDialogState.init:
          break;
      }
    }
  }

  bool showLoading() {
    return signIn.running || signOut.running || createUser.running;
  }

  void toggleTheme() {
    _themeNotifier.toggleTheme();
  }

  /// Getters and Setters
  DialogEventNotifier<AuthMessageType> get dialogEventNotifier =>
      _dialogEventNotifier;

  UserStorageChangeNotifier get userChangeNotifier => _userChangeNotifier;
}
