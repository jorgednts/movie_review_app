import 'package:app/src/domain/use_case/auth/check_user_logged_use_case.dart';
import 'package:app/src/domain/use_case/auth/create_user_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_in_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_out_use_case.dart';
import 'package:app/src/presentation/ui/shell/widgets/auth_dialog.dart';
import 'package:core/core.dart';

enum AuthMessageType { signIn, signOut, createUser }

class ShellViewModel extends BaseViewModel {
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final CreateUserUseCase _createUserUseCase;
  final CheckUserLoggedUseCase _checkUserLoggedUseCase;
  final DialogEventNotifier<AuthMessageType> _dialogEventNotifier;
  final AuthChangeNotifier _authChangeNotifier;

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
    required AuthChangeNotifier authChangeNotifier,
  }) : _signInUseCase = signInUseCase,
       _signOutUseCase = signOutUseCase,
       _createUserUseCase = createUserUseCase,
       _checkUserLoggedUseCase = checkUserLoggedUseCase,
       _dialogEventNotifier = dialogEventNotifier,
       _authChangeNotifier = authChangeNotifier;

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
        authChangeNotifier.setUser(result);
      },
      onError: (error) {
        authChangeNotifier.setUser(null);
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
        authChangeNotifier.setUser(null);
      },
      onError: (error) {},
      onFinally: () {
        _dialogEventNotifier.trigger(AuthMessageType.signOut);
      },
    );
  }

  Future<Result> _createUser(UserRequest input) async {
    return await callUseCase<UserRequest, bool>(
      useCase: _createUserUseCase,
      input: input,
      onSuccess: (result) {},
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
        authChangeNotifier.setUser(result);
      },
      onError: (error) {
        authChangeNotifier.setUser(null);
      },
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

  /// Getters and Setters
  DialogEventNotifier<AuthMessageType> get dialogEventNotifier =>
      _dialogEventNotifier;

  AuthChangeNotifier get authChangeNotifier => _authChangeNotifier;
}
