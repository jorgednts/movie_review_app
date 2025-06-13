import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/common/widgets/app_logo_widget.dart';
import 'package:app/src/presentation/ui/shell/dependency/shell_dependency.dart';
import 'package:core/core.dart';
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
    return WindowUtils.isDesktop(context)
        ? DefaultNavigationBar(
          navigationMenu: DefaultNavigationMenu(
            destinations:
                ShellDependency.customShellBranches
                    .map((item) => item.appRoute.nameValue(context))
                    .toList(),
            onDestinationSelected: navigationShell.goBranch,
            currentIndex: navigationShell.currentIndex,
          ),
          leading: TextButton(
            onPressed: () => navigationShell.goBranch(0),
            style: const ButtonStyle(
              overlayColor: WidgetStateColor.transparent,
            ),
            child: const AppLogoWidget(),
          ),
          trailing: authButton,
        )
        : Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.spacingMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppLogoWidget(),
              Align(alignment: Alignment.centerRight, child: authButton),
            ],
          ),
        );
  }
}
