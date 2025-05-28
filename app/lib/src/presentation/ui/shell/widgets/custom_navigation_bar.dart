import 'package:app/src/presentation/ui/common/widgets/app_logo_widget.dart';
import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.navigationShell,
    required this.userModelListenable,
    required this.onSignIn,
    required this.onSignOut,
    required this.checkUserLoggedCommand,
  });

  final StatefulNavigationShell navigationShell;
  final ValueNotifier<UserModel?> userModelListenable;
  final void Function() onSignIn;
  final void Function() onSignOut;
  final Command0<void> checkUserLoggedCommand;

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
      trailing: ListenableBuilder(
        listenable: checkUserLoggedCommand,
        builder: (_, __) {
          if (checkUserLoggedCommand.running) {
            return SizedBox();
          }
          return ValueListenableBuilder<UserModel?>(
            valueListenable: userModelListenable,
            builder:
                (context, user, child) => OutlinedButton(
                  onPressed: user == null ? onSignIn : onSignOut,
                  child: Text(
                    user == null
                        ? AppIntl.of(context).shell_sign_in
                        : AppIntl.of(context).shell_sign_out,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
