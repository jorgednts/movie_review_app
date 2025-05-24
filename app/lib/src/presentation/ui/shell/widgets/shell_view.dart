import 'package:app/src/presentation/common/widgets/app_logo_widget.dart';
import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/utils/window_utils.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellView extends StatelessWidget {
  const ShellView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          WindowUtils.isDesktop(context)
              ? null
              : AppBar(centerTitle: true, title: AppLogoWidget()),
      body: SafeArea(
        child: Column(
          children: [
            if (WindowUtils.isDesktop(context))
              DefaultNavigationBar(
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
                  style: ButtonStyle(
                    overlayColor: WidgetStateColor.transparent,
                  ),
                  child: AppLogoWidget(),
                ),
                trailing: SizedBox(child: Text('Placeholder')),
              ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1500),
                child: navigationShell,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          WindowUtils.isDesktop(context)
              ? null
              : NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: navigationShell.goBranch,
                destinations:
                    AppRouter.customShellBranches
                        .map(
                          (item) =>
                              item.appRoute.toNavigationDestination(context),
                        )
                        .toList(),
              ),
    );
  }
}
