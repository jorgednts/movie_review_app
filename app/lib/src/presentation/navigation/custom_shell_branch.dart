import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:go_router/go_router.dart';

class CustomShellBranch {
  final AppRoute appRoute;
  final List<GoRoute> routes;

  const CustomShellBranch({required this.appRoute, required this.routes});

  StatefulShellBranch buildStatefulShellBranch() {
    return StatefulShellBranch(routes: routes);
  }
}
