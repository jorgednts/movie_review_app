import 'package:app/src/presentation/ui/shell/widgets/user_listenable_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class NavigationBarAuthButton extends StatelessWidget {
  const NavigationBarAuthButton({
    super.key,
    required this.onSignIn,
    required this.onSignOut,
  });

  final void Function() onSignIn;
  final void Function() onSignOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimensions.spacingMd,
      children: [
        Consumer<ThemeNotifier>(
          builder: (_, themeNotifier, child) {
            final themeMode = themeNotifier.themeMode;
            return IconButton.outlined(
              onPressed: themeNotifier.toggleTheme,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              icon: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.wb_sunny_outlined
                    : Icons.nights_stay_outlined,
              ),
            );
          },
        ),
        UserListenableWidget(
          child: Consumer<UserStorageChangeNotifier>(
            builder: (context, authChangeNotifier, child) {
              final user = authChangeNotifier.user;
              final username =
                  authChangeNotifier.userStorageModel?.name.toUpperCase() ?? '';
              return user == null
                  ? IconButton(
                    onPressed: onSignIn,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    icon: Icon(Icons.person_outline),
                  )
                  : IconButton.filledTonal(
                    onPressed:
                        () => showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width,
                            kToolbarHeight + Dimensions.spacingXs,
                            0,
                            0,
                          ),
                          items: [
                            PopupMenuItem(
                              onTap: onSignOut,
                              child: ListTile(
                                title: Text(AppIntl.of(context).shell_sign_out),
                                leading: Icon(Icons.logout),
                              ),
                            ),
                          ],
                        ),
                    icon:
                        username.isEmpty
                            ? Icon(Icons.person_outline)
                            : Text(
                              username.substring(0, 1),
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSecondaryContainer,
                              ),
                            ),
                  );
            },
          ),
        ),
      ],
    );
  }
}
