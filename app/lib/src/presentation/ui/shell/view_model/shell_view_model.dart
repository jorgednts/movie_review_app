import 'package:app/src/domain/use_case/auth/check_user_logged_use_case.dart';
import 'package:app/src/domain/use_case/auth/create_user_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_in_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_out_use_case.dart';
import 'package:app/src/presentation/ui/shell/widgets/auth_dialog.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

enum MessageType { signIn, signOut, createUser }

class ShellViewModel extends BaseViewModel {
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final CreateUserUseCase _createUserUseCase;
  final CheckUserLoggedUseCase _checkUserLoggedUseCase;

  ShellViewModel({
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
    required CreateUserUseCase createUserUseCase,
    required CheckUserLoggedUseCase checkUserLoggedUseCase,
  }) : _signInUseCase = signInUseCase,
       _signOutUseCase = signOutUseCase,
       _createUserUseCase = createUserUseCase,
       _checkUserLoggedUseCase = checkUserLoggedUseCase;

  // Commands
  late final Command1<void, UserRequest> signIn;
  late final Command0<void> signOut;
  late final Command1<void, UserRequest> createUser;
  late final Command0<void> checkUserLogged;

  ValueNotifier<UserModel?> user = ValueNotifier(null);
  MessageType resultMessageType = MessageType.signIn;

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
    resultMessageType = MessageType.signIn;
    return await request<UserRequest, UserModel?>(
      useCase: _signInUseCase,
      input: input,
      onSuccess: (result) {
        user.value = result;
      },
      onError: (error) {},
    );
  }

  Future<Result> _signOut() async {
    resultMessageType = MessageType.signOut;
    return await request<NoParam, void>(
      useCase: _signOutUseCase,
      input: NoParam(),
      onSuccess: (result) {
        user.value = null;
      },
      onError: (error) {},
    );
  }

  Future<Result> _createUser(UserRequest input) async {
    resultMessageType = MessageType.createUser;
    return await request<UserRequest, bool>(
      useCase: _createUserUseCase,
      input: input,
      onSuccess: (result) {},
      onError: (error) {},
    );
  }

  Future<Result> _checkUserLogged() async {
    return await request<NoParam, UserModel?>(
      useCase: _checkUserLoggedUseCase,
      input: NoParam(),
      onSuccess: (result) {
        user.value = result;
      },
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
}
