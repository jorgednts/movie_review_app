import 'package:app/src/domain/repository/auth_repository.dart';
import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:app/src/domain/use_case/auth/create_user_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_in_use_case.dart';
import 'package:app/src/domain/use_case/auth/sign_out_use_case.dart';
import 'package:app/src/domain/use_case/auth/stream_user_changes_use_case.dart';
import 'package:app/src/domain/use_case/storage/create_user_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_username_use_case.dart';
import 'package:app/src/presentation/ui/home/dependency/home_dependency.dart';
import 'package:app/src/presentation/ui/reviews/dependency/reviews_dependency.dart';
import 'package:app/src/presentation/ui/search/dependency/search_dependency.dart';
import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:app/src/presentation/ui/shell/widgets/shell_view.dart';
import 'package:app/src/presentation/ui/watchlist/dependency/watchlist_dependency.dart';
import 'package:app/src/presentation/utils/custom_theme_notifier.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShellDependency {
  static final dependency = StatefulShellRoute.indexedStack(
    builder:
        (context, state, navigationShell) => Provider(
          create: (context) {
            final authRepository = context.read<AuthRepository>();
            final storageRepository = context.read<CoreStorageRepository>();
            final userStorageNotifier =
                context.read<UserStorageChangeNotifier>();
            return ShellViewModel(
              signInUseCase: SignInUseCase(authRepository: authRepository),
              signOutUseCase: SignOutUseCase(authRepository: authRepository),
              createUserUseCase: CreateUserUseCase(
                authRepository: authRepository,
              ),
              dialogEventNotifier: MessageEventNotifier<AuthMessageType>(),
              createUserStorageUseCase: CreateUserStorageUseCase(
                coreStorageRepository: storageRepository,
              ),
              getUserStorageUseCase: GetCollectionFromStorageUseCase(
                coreStorageRepository: storageRepository,
              ),
              getUsernameUseCase: GetUsernameUseCase(
                coreStorageRepository: storageRepository,
              ),
              userChangeNotifier: userStorageNotifier,
              streamUserChangesUseCase: StreamUserChangesUseCase(
                authRepository: authRepository,
              ),
              themeNotifier: context.read<CustomThemeNotifier>(),
            );
          },
          child: ShellView(navigationShell: navigationShell),
        ),
    branches:
        customShellBranches
            .map((item) => item.buildStatefulShellBranch())
            .toList(),
  );

  static final customShellBranches = [
    HomeDependency.dependency,
    SearchDependency.dependency,
    ReviewsDependency.dependency,
    WatchlistDependency.dependency,
  ];
}
