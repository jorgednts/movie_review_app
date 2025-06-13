import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/details/dependency/details_dependency.dart';
import 'package:app/src/presentation/ui/shell/dependency/shell_dependency.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: CustomModalNavigator.modalNavigatorKey,
    initialLocation: AppRoute.home.path,
    onException: (context, _, _) => context.goNamed(AppRoute.home.name),
    routes: [ShellDependency.dependency, DetailsDependency.dependency],
  );
}
