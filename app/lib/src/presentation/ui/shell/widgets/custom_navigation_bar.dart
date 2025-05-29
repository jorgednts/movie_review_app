import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/common/widgets/app_logo_widget.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.navigationShell,
    required this.authButton,
  });

  final StatefulNavigationShell navigationShell;
  final Widget authButton;

  @override
  Widget build(BuildContext context) {
    return DefaultNavigationBar(
      navigationMenu: DefaultNavigationMenu(
        destinations:
            AppRouter.customShellBranches
                .map((item) => item.appRoute.nameValue(context))
                .toList(),
        onDestinationSelected: navigationShell.goBranch,
        currentIndex: navigationShell.currentIndex,
      ),
      leading: TextButton(
        onPressed: () => navigationShell.goBranch(0),
        style: ButtonStyle(overlayColor: WidgetStateColor.transparent),
        child: AppLogoWidget(),
      ),
      trailing: authButton,
    );
  }
}
