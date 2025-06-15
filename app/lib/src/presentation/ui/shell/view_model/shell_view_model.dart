import 'package:app/src/domain/use_case/auth/create_user_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_in_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_out_use_case.dart';
import 'package:app/src/domain/use_case/auth/stream_user_changes_use_case.dart';
import 'package:app/src/domain/use_case/storage/create_user_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_username_use_case.dart';
import 'package:app/src/presentation/utils/custom_theme_notifier.dart';
import 'package:core/core.dart';

enum AuthMessageType {
  successSignIn,
  successSignOut,
  successCreateUser,
  errorSignIn,
  errorSignOut,
  errorCreateUser,
}

class ShellViewModel extends BaseViewModel {
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final CreateUserUseCase _createUserUseCase;
  final GetUsernameUseCase _getUsernameUseCase;
  final MessageEventNotifier<AuthMessageType> _dialogEventNotifier;
  final CreateUserStorageUseCase _createUserStorageUseCase;
  final UserStorageChangeNotifier _userChangeNotifier;
  final StreamUserChangesUseCase _streamUserChangesUseCase;
  final CustomThemeNotifier _themeNotifier;

  // Commands
  late final Command1<void, UserRequest> signIn;
  late final Command0<void> signOut;
  late final Command1<void, UserRequest> createUser;

  ShellViewModel({
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
    required CreateUserUseCase createUserUseCase,
    required MessageEventNotifier<AuthMessageType> dialogEventNotifier,
    required UserStorageChangeNotifier userChangeNotifier,
    required CreateUserStorageUseCase createUserStorageUseCase,
    required GetCollectionFromStorageUseCase getUserStorageUseCase,
    required GetUsernameUseCase getUsernameUseCase,
    required StreamUserChangesUseCase streamUserChangesUseCase,
    required CustomThemeNotifier themeNotifier,
  }) : _signInUseCase = signInUseCase,
       _signOutUseCase = signOutUseCase,
       _createUserUseCase = createUserUseCase,
       _dialogEventNotifier = dialogEventNotifier,
       _userChangeNotifier = userChangeNotifier,
       _createUserStorageUseCase = createUserStorageUseCase,
       _getUsernameUseCase = getUsernameUseCase,
       _streamUserChangesUseCase = streamUserChangesUseCase,
       _themeNotifier = themeNotifier;

  @override
  void onInit() {
    super.onInit();
    _streamUserChangesUseCase.userChanges.listen(_listenUserChanges);
  }

  @override
  void initCommands() {
    signIn = Command1(_signIn);
    signOut = Command0(_signOut);
    createUser = Command1(_createUser);
  }

  AsyncResult _signIn(UserRequest input) async {
    return await callUseCase<UserRequest, UserModel?>(
      useCase: _signInUseCase,
      input: input,
      onSuccess: (result) {
        _dialogEventNotifier.trigger(AuthMessageType.successSignIn);
      },
      onError: (error) {},
    );
  }

  AsyncResult _signOut() async {
    return await callUseCase<NoParam, void>(
      useCase: _signOutUseCase,
      input: NoParam(),
      onSuccess: (result) {
        _dialogEventNotifier.trigger(AuthMessageType.successSignOut);
      },
      onError: (error) {},
    );
  }

  AsyncResult _createUser(UserRequest input) async {
    return await callUseCase<UserRequest, UserModel>(
      useCase: _createUserUseCase,
      input: input,
      onSuccess: (result) {
        final userStorageRequest = CreateUserStorageRequest(
          user: result,
          name: input.name,
        );
        _createUserStorage(userStorageRequest);
        _dialogEventNotifier.trigger(AuthMessageType.successCreateUser);
      },
      onError: (error) {},
    );
  }

  AsyncResult _createUserStorage(
    CreateUserStorageRequest storageRequest,
  ) async {
    return await callUseCase<CreateUserStorageRequest, void>(
      useCase: _createUserStorageUseCase,
      input: storageRequest,
      onSuccess: (result) {},
      onError: (error) {},
    );
  }

  AsyncResult _getUsername(String uid) async {
    return await callUseCase<String, String>(
      useCase: _getUsernameUseCase,
      input: uid,
      onSuccess: (result) {
        if (userChangeNotifier.user != null) {
          userChangeNotifier.setUserStorageModel(
            UserStorageModel(user: userChangeNotifier.user!, name: result),
          );
        }
      },
      onError: (error) {},
    );
  }

  void _listenUserChanges(UserModel? user) {
    userChangeNotifier.setUser(user);
    if (user != null) {
      _getUsername(user.uid);
    }
  }

  bool showLoading() {
    return signIn.running || signOut.running || createUser.running;
  }

  void toggleTheme() {
    _themeNotifier.toggleTheme();
  }

  /// Getters and Setters
  MessageEventNotifier<AuthMessageType> get dialogEventNotifier =>
      _dialogEventNotifier;

  UserStorageChangeNotifier get userChangeNotifier => _userChangeNotifier;
}
